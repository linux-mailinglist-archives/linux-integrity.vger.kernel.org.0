Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC975ED62
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jul 2023 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGXIYB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jul 2023 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGXIX5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jul 2023 04:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E921A1
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jul 2023 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690186990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye5hZVkJgwhIyK0/JiD2r7SsrzVvzq+O4olxaiN3AL0=;
        b=F+2s+me9rO5vudcwYoy6MgRc9ZtfscGQ0X9js9zbsvDLfpe2R+cxfhFpe1nScJWItRgufG
        9NghFo95CDEACYXl5cX/Rgy5HAnJTnp1AsJ0LZEEA3YBiMQsB8aXdta9gR3E5rTdw9fgLr
        Nj90PJNIsbkAElvHOmvlGtaJShxZ7zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-P7kk_43WOo2WA6SRQLK3gg-1; Mon, 24 Jul 2023 04:23:07 -0400
X-MC-Unique: P7kk_43WOo2WA6SRQLK3gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FF481D9EC;
        Mon, 24 Jul 2023 08:23:06 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D31661121315;
        Mon, 24 Jul 2023 08:23:04 +0000 (UTC)
Date:   Mon, 24 Jul 2023 16:23:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Wenyu Liu(D)" <liuwenyu7@huawei.com>
Cc:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, ebiederm@xmission.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
Message-ID: <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 07/24/23 at 11:45am, Wenyu Liu(D) wrote:
> kexec_mutex is replaced by an atomic variable in
> 56314b90fd43bd2444 (panic, kexec: make __crash_kexec() NMI safe).

You could use a distros kernel or customized kernel and made change
based on that. The commit id isn't correct. I pasted the right one
at below.

commit 05c6257433b ("panic, kexec: make __crash_kexec() NMI safe")

Other than this, this looks good. You can post a new one with my ack.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Fix some comment that still using kexec_mutex.
> 
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
> ---
>  kernel/kexec_file.c                | 2 +-
>  security/integrity/ima/ima_kexec.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 881ba0d1714c..b5bbb2fe0668 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:  Buffer contents and memory parameters.
>   *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>   * On successful return, @kbuf->mem will have the physical address of
>   * the buffer in memory.
>   *
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..ad133fe120db 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   * Called during kexec_file_load so that IMA can add a segment to the kexec
>   * image for the measurement list for the next kernel.
>   *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>   */
>  void ima_add_kexec_buffer(struct kimage *image)
>  {
> --
> 2.33.0
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

