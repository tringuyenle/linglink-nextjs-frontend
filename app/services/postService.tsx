import { AxiosResponse } from "axios";
import createAxiosInstance from "../utils/axiosInstance";
import { CommentService } from "./commentService";

export class PostService {
  static async getPostById(id: string): Promise<AxiosResponse<any>> {
    const axiosInstance = createAxiosInstance();
    const response: AxiosResponse<any> = await axiosInstance.get(
      `${process.env.NEXT_PUBLIC_BASE_URL}/posts/${id}`,
      {
        params: {
          id: id,
        },
      }
    );
    return response;
  }

  static async createPost(post: any): Promise<AxiosResponse<any>> {
    const axiosInstance = createAxiosInstance();
    const response: AxiosResponse<any> = await axiosInstance.post(
      `${process.env.NEXT_PUBLIC_BASE_URL}/posts`,
      post
    );
    return response;
  }

  static async updatePostById(
    postId: any,
    postData: any
  ): Promise<AxiosResponse<any>> {
    const axiosInstance = createAxiosInstance();
    const response: AxiosResponse<any> = await axiosInstance.put(
      `${process.env.NEXT_PUBLIC_BASE_URL}/posts/${postId}`,
      postData
    );
    return response;
  }

  static async deletePost(
    postid: any
  ): Promise<[AxiosResponse<any>, AxiosResponse<any>]> {
    const axiosInstance = createAxiosInstance();
    const [deletePostResponse, deleteCommentsResponse] = await Promise.all([
      axiosInstance.delete(
        `${process.env.NEXT_PUBLIC_BASE_URL}/posts/${postid}`
      ),
      CommentService.deleteCommentsByPostId(postid),
    ]);
    return [deletePostResponse, deleteCommentsResponse];
  }
}
