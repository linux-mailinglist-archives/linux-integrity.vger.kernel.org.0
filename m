Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14586D37
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2019 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfHHW1A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 18:27:00 -0400
Received: from foss.arm.com ([217.140.110.172]:39522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404636AbfHHW07 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 18:26:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB72F15A2;
        Thu,  8 Aug 2019 15:26:58 -0700 (PDT)
Received: from c02sv19cfvh4.usa.arm.com (c02sv19cfvh4.usa.arm.com [10.118.108.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02DF3F575;
        Thu,  8 Aug 2019 15:26:58 -0700 (PDT)
Subject: Re: [Tee-dev] [RFC v2 2/6] tee: enable support to register kernel
 memory
To:     Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     tee-dev@lists.linaro.org, daniel.thompson@linaro.org,
        corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org,
        linux-doc@vger.kernel.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, casey@schaufler-ca.com,
        linux-arm-kernel@lists.infradead.org, serge@hallyn.com
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
From:   Stuart Yoder <stuart.yoder@arm.com>
Message-ID: <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
Date:   Thu, 8 Aug 2019 17:26:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/30/19 7:23 AM, Sumit Garg wrote:

> @@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>   		goto err;
>   	}
>   
> -	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> +	if (flags & TEE_SHM_USER_MAPPED) {
> +		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> +					 shm->pages);
> +	} else {
> +		const struct kvec kiov = {
> +			.iov_base = (void *)start,
> +			.iov_len = PAGE_SIZE
> +		};
> +
> +		rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);

Passing a single kvec struct is temporary I assume?  Because as currently
written this will only work with num_pages==1.

Stuart
