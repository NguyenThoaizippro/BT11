package vn.iotstar.entity;

import jakarta.persistence.*;
import lombok.*;
import vn.iotstar.util.OrderStatus_24110342;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order_24110342 implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User_24110342 user;

    @Column(name = "receiver_name", length = 50)
    private String receiverName;

    @Column(name = "receiver_phone", length = 15)
    private String receiverPhone;

    @Column(name = "receiver_address", length = 255)
    private String receiverAddress;

    @Column(name = "note", length = 255)
    private String note;

    @Column(name = "payment_method", length = 20)
    private String paymentMethod;

    @Column(name = "total_amount", precision = 12, scale = 2)
    private BigDecimal totalAmount;

    @Column(name = "status", length = 20)
    private String status;

    @Column(name = "created_at")
    private Timestamp createdAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @Builder.Default
    private List<OrderDetail_24110342> details = new ArrayList<>();

    public String getStatusLabel() {
        return OrderStatus_24110342.label(status);
    }

    public String getStatusColor() {
        return OrderStatus_24110342.color(status);
    }

    public int getItemCount() {
        return (details != null) ? details.size() : 0;
    }
}
