Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131A1109374
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 19:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKYSXv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 13:23:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39578 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfKYSXv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 13:23:51 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAEFF20B7185;
        Mon, 25 Nov 2019 10:23:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAEFF20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574706230;
        bh=v8SFYp7z23zdTD9mpm2D2f8oNk3RRUpHVTzQAbJK8qI=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=l9HKGUHkwvL65388lebvDM1KkrEQrMYqF/wDSUGxvcMPR2aiXuce8DFJUdQYeL3aC
         unafvQOBL5Z4cIOUlfkiukXI0ODbOWE4LxcYONgfBefvQTLLzdsxauz71/iH9dw+mU
         2PkS928Yi1dHasOdU1zmze0Cffhrif5k3bQAq0U8=
Subject: Re: [PATCH v0] IMA: Check IMA policy flag
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org
References: <20191121171444.2797-1-nramas@linux.microsoft.com>
Message-ID: <5a43ec9d-af82-9a31-3546-76e8328ff213@linux.microsoft.com>
Date:   Mon, 25 Nov 2019 10:23:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121171444.2797-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/21/19 9:14 AM, Lakshmi Ramasubramanian wrote:

Hi Mimi,

> process_buffer_measurement() needs to check if ima_policy_flag
> is set to measure and\or appraise. Not doing this check can
> result in kernel panic (such as when process_buffer_measurement()
> is called before IMA is initialized).
>  
> This change adds the check in process_buffer_measurement()
> to return immediately if ima_policy_flag is set to 0.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 60027c643ecd..c9374430bb72 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -651,6 +651,9 @@ static void process_buffer_measurement(const void *buf, int size,
>   	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>   	int action = 0;
>   
> +	if (!ima_policy_flag)
> +		return;
> +

Please let me know if the above change would be accepted as a standalone 
patch (like the one in this patch),
or, I should include this change as one of the patches in the "Key 
Measurement" patch set?

thanks,
  -lakshmi
