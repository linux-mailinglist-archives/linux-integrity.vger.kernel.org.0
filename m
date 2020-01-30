Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2847B14DF77
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 17:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3QxX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 11:53:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48128 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3QxX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 11:53:23 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8F9FC2008823;
        Thu, 30 Jan 2020 08:53:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F9FC2008823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1580403202;
        bh=6u2e4utCv06M2/EwYUSUx/pCN776xEEyDnF/FBecuMo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JsHO66/2/Zk8xjQZsETKMnysO4RHQBlhEE32CKoz12JcE9hp3ahExAllWTt4WVHNq
         WiC5IyWPZgb7R7XV8mZsxVpzzpi/AZyQxTUIh1RtXAxrowX3iP1QAXqXZ7e6PfP4RR
         0fIRArL6Q3oUVnLy/jw50jaaoq2+5SQ/1m9pDGYA=
Subject: Re: [PATCH v3 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
References: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
 <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <480498cc-861b-7efa-de6a-52bc651aad01@linux.microsoft.com>
Date:   Thu, 30 Jan 2020 08:53:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/30/2020 8:22 AM, Mimi Zohar wrote:

> +static enum hash_algo get_hash_algo(const char *algname)
> +{
> +	int i;
> +
> +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> +		if (strcmp(algname, hash_algo_name[i]) == 0)
> +			break;
> +	}
> +
> +	return i;
> +}
> +

ima_digest_data is passed to ima_calc_boot_aggregate(). This struct 
contains the hash_algo. Can that be passed to 
ima_calc_boot_aggregate_tfm() instead of using the above function to get 
the hash_algo?

  -lakshmi
