export interface RentRoomDetailRouteParams {
  id: string;
}

export interface LoginCodeRouteParams {
  phone: string;
}

export type RouteParams = Partial<RentRoomDetailRouteParams> & Partial<LoginCodeRouteParams>;
