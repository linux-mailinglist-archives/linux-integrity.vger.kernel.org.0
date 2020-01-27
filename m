Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7287A14A855
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgA0QuL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 11:50:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0QuK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 11:50:10 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3A12F2008819;
        Mon, 27 Jan 2020 08:50:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A12F2008819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1580143810;
        bh=7k4I5TR6svwojaafQlq2biwEquSFHairvhblaQP/HX4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GKmrRVPGRylTaUJkzQQYSUjlQYpJi+TeRZLqPRe5/kYiU3QKImNBE6fnHhOuIrhz6
         c8KTLy1ZkhIW5srFxoJp0y200Nl+ibnTEywdcpeeR2kahsTs8LkNeLMJCs7FeqvXjg
         Bfbb7p6lni2I+PKKYGD5fEFWPuLw5mcgbLkwKxm4=
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
 <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <87e6b531-3596-4523-a6b0-629ae8fd6995@linux.microsoft.com>
Date:   Mon, 27 Jan 2020 08:50:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/27/2020 8:01 AM, Mimi Zohar wrote:

> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> +		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
> +			break;
> +	}
> +
> +	if (i == ima_tpm_chip->nr_allocated_banks)
> +		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
> +

Can the number of allocated banks (ima_tpm_chip->nr_allocated_banks) be 
zero? Should that be checked before accessing "allocated_banks"?

  -lakshmi
