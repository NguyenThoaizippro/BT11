package vn.iotstar.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RatingId_24110342 implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer userid;
    private Integer bookid;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RatingId_24110342 ratingId = (RatingId_24110342) o;
        return Objects.equals(userid, ratingId.userid) && Objects.equals(bookid, ratingId.bookid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userid, bookid);
    }
}
