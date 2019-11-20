Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7228A104709
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 00:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTXjw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 18:39:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52866 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTXjw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 18:39:52 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7CE8420B7185;
        Wed, 20 Nov 2019 15:39:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CE8420B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574293191;
        bh=fBnSdarksQEg07LJd/+YN30Ehp+o/3EE9sMPeU4CzwY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GwkKe1t8XcQy5/t9J/I76+iHZbWRwe/ShA4SV2K0yqN5TXRt1H+UVkm4E5PIdKP8O
         OvnLTPQ8wVn1QShs0AtKRHEBDfdzitYVL/sGQkmelkt8xWALdG0fdSi8gvyPbtPEq8
         8opQIcAbpWNqaLAdJX+U8vjwRek6kpbLHcwZ03aI=
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
 <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 15:40:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/20/2019 3:28 PM, Eric Snowberg wrote:
Hi Eric,

> 
> I’m interested in using this patch series, however I get the following on every boot:

> [    1.222749] Call Trace:
> [    1.223344]  ? crypto_destroy_tfm+0x5f/0xb0
> [    1.224315]  ima_get_action+0x2c/0x30
> [    1.225148]  process_buffer_measurement+0x1da/0x230
> [    1.226306]  ima_post_key_create_or_update+0x3b/0x40

This is happening because IMA is not yet initialized when the IMA hook 
is called.

I had the following check in process_buffer_measurement() as part of my 
patch, but removed it since it is being upstreamed separately (by Mimi)

  if (!ima_policy_flag)
  	return;

Until this change is in, please add the above line locally on entry to 
process_buffer_measurement() to get around the issue.

thanks,
  -lakshmi
