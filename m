Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A667677388
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 00:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjAVXmo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Jan 2023 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjAVXmn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Jan 2023 18:42:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EE1BC0
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 15:42:41 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y19so11486952ljq.7
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 15:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRBwIm81edqT4Ut9SPv7xKB300dnJn1eIc5f0W2k7TY=;
        b=DXn1QQtNJeCJxXSAWx5h65LjU1/8yxl3cOg79BSzra+Flh/JwpcHWsEz1YFXnz1FJM
         o8lgM0m6SVD0kisHOVOzELaB1GEuG+deFDkoCZdVYcdaomsJ8TRsZtmJg1KXq3BexKV1
         fg9aZbops4esJ+V2z4cEaBvelk5JDL5htGM0UP2+zajV8dm+Vh53YL/lFTfdM/tSJW6a
         W6YbjgtLVGX9Bh/v3KrN+Vk8/uHRDchHjAcnr7Wi16DeTROO8XSVj/uDF0jnYgZ/7lsW
         hCk0qsClfzR7W9QB5RkIy6LWPK7MzVc2CihMMTImO7xBhjsAhQpdo0zhVchYTRCLIBdh
         ZrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRBwIm81edqT4Ut9SPv7xKB300dnJn1eIc5f0W2k7TY=;
        b=sJEysVmzrW2jg2G9AsD0x/hqf2K0M2LiDov0A0XFDfOl9RiXwGACzmXPRGnTAHGVqs
         b7orJAZ6ODb5FpIg14CXpQBovGMlkF5gUiA38LE7NDWO/vTW9BemhO/9WbSrNK0wmqZx
         YkvmS00ZA0HoSjaM+AITuRK1HHMVN88PL6sDJFvGSj6G33OmbvHnseKbrkZmNdZRnUek
         cylNY3AR51UVVh78N+GX//WXoEz+dgjV6VlKD8GgginS0KGGe9Smiu/T33MMShXF6nS/
         DL/XuxVeqdIAZec1V5ZLtDFfvLGWTr4Ix0LgWyQEyzAq5JEtvOL1cJLlz3Jh4C1n+USd
         uNzg==
X-Gm-Message-State: AFqh2kp/UgH/qBc+LL17uk2Qu+tB01LtqsUdt/N8FjlwXKAXreQzFqY2
        AvvPVvpbmXSEdg2SiP2Ne9zmKA==
X-Google-Smtp-Source: AMrXdXuGsJCqsSekfjYLU/CYgSdyhxkCdnCiyEWoEwpls657m4RBiIE4r76m2+LpLJDU3DQSCIUa9g==
X-Received: by 2002:a2e:9811:0:b0:286:ad70:a1f7 with SMTP id a17-20020a2e9811000000b00286ad70a1f7mr8643075ljj.34.1674430959978;
        Sun, 22 Jan 2023 15:42:39 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0028b8d0bb0casm2143076ljc.67.2023.01.22.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 15:42:39 -0800 (PST)
Date:   Sun, 22 Jan 2023 23:42:34 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, revest@google.com,
        kpsingh@google.com, roberto.sassu@huawei.com
Subject: Re: [PATCH] ima: return IMA digest value only when IMA_COLLECTED
 flag is set
Message-ID: <Y83J6hPruCtA5D93@google.com>
References: <Y7T1hEhIL5TEmLEN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7T1hEhIL5TEmLEN@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey Mimi,

Just a gentle ping on this one.

On Wed, Jan 04, 2023 at 03:41:56AM +0000, Matt Bobrowski wrote:
> The IMA_COLLECTED flag indicates whether the IMA subsystem has
> successfully collected a measurement for a given file object. Ensure
> that we return the respective digest value stored within the iint
> entry only when this flag has been set.
> 
> Failing to check for the presence of this flag exposes consumers of
> this IMA API to receive potentially undesired IMA digest values when
> an erroneous condition has been experienced in some of the lower level
> IMA API code.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  security/integrity/ima/ima_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index b1ae0f2751f1..1d40cdfa23d5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -563,7 +563,7 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
>  	 * ima_file_hash can be called when ima_collect_measurement has still
>  	 * not been called, we might not always have a hash.
>  	 */
> -	if (!iint->ima_hash) {
> +	if (!iint->ima_hash || !(iint->flags & IMA_COLLECTED)) {
>  		mutex_unlock(&iint->mutex);
>  		return -EOPNOTSUPP;
>  	}
> -- 
> 2.39.0.314.g84b9a713c41-goog

/M
