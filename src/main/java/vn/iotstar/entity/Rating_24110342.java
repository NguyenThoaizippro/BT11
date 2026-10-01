package vn.iotstar.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity
@Table(name = "rating")
@IdClass(RatingId_24110342.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Rating_24110342 implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "userid")
    private Integer userid;

    @Id
    @Column(name = "bookid")
    private Integer bookid;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "review_text", columnDefinition = "TEXT")
    private String reviewText;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userid", insertable = false, updatable = false)
    private User_24110342 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bookid", insertable = false, updatable = false)
    private Book_24110342 book;
}
