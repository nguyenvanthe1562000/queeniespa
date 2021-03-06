export class PagingRequest {
    ParentId: number;
    PageIndex : number;    
    PageSize : number;     
    OrderBy : string;   
    OrderDesc : boolean;  
    FilterColumn : string;     
    FilterType : FilterType;  
    FilterValue : string
    DataIsActive: boolean;
   
}
    
export enum FilterType {
    NotEmpty,
    Empty,
    Contains,
    StartsWith,
    EndsWith,
    Equals,
    GreaterThan,
    LessThan
 }