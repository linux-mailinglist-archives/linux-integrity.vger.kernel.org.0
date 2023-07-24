Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E0275EE58
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jul 2023 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGXIvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jul 2023 04:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGXIvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jul 2023 04:51:05 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9328131;
        Mon, 24 Jul 2023 01:51:01 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9081461E5FE01;
        Mon, 24 Jul 2023 10:49:55 +0200 (CEST)
Message-ID: <e8be33b7-efc2-52b3-35fe-17aca9c8767b@molgen.mpg.de>
Date:   Mon, 24 Jul 2023 10:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
Content-Language: en-US
To:     Wenyu Liu <liuwenyu7@huawei.com>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
Cc:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, ebiederm@xmission.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Wenyu,


Thank you for your patch. Some minor comments, you can ignore.

Am 24.07.23 um 05:45 schrieb Wenyu Liu(D):

The (D) looks strange. At least a space should be added before the (.

> kexec_mutex is replaced by an atomic variable in
> 56314b90fd43bd2444 (panic, kexec: make __crash_kexec() NMI safe).
> 
> Fix some comment that still using kexec_mutex.

comment*s*

> 
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>

Due to the (D) this doesn’t exactly match with the Author field. You 
also have two spaces before < instead of one.

Also for the commit message summary you could be more specific:

 > kexec_lock: Replace kexec_mutex() by kexec_lock() in two comments

At least, please add a space after the colon (:).

> ---
>   kernel/kexec_file.c                | 2 +-
>   security/integrity/ima/ima_kexec.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 881ba0d1714c..b5bbb2fe0668 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>    * kexec_add_buffer - place a buffer in a kexec segment
>    * @kbuf:  Buffer contents and memory parameters.
>    *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>    * On successful return, @kbuf->mem will have the physical address of
>    * the buffer in memory.
>    *
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..ad133fe120db 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>    * Called during kexec_file_load so that IMA can add a segment to the kexec
>    * image for the measurement list for the next kernel.
>    *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>    */
>   void ima_add_kexec_buffer(struct kimage *image)
>   {
> --
> 2.33.0


Kind regards,

Paul
