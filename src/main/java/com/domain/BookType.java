package com.domain;

public class BookType {

    private Integer id;
    private Integer typeId;
    private String type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "BookType{" +
                "id=" + id +
                ", typeId=" + typeId +
                ", type='" + type + '\'' +
                '}';
    }
}
