Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99B2135E72
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 17:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgAIQiQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 11:38:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39062 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgAIQiP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 11:38:15 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id F2CAF2007684;
        Thu,  9 Jan 2020 08:38:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2CAF2007684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578587895;
        bh=tLUd4VK7GfUjhPceZ2DEioxJk5pIIIxabfHz0xCY7KA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DFTve4DqG+WRFl5jxDn11pDsh+qB2yu/lMwI7WyqHieA5FllIu/xbZkU0MaAkifBc
         NyYW0i2hCHFPcRkMmbopmX8hrd/1BGS0PH44ZSZoF/hTwFh7ybOr3SNGZPDZiJq9u/
         IIwnrGFXQ0vyBXacypwUIPAb26ZY2iUdu+ccNldc=
Subject: Re: [PATCH v1] IMA: fix measuring asymmetric keys Kconfig
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20200108160508.5938-1-nramas@linux.microsoft.com>
 <1578545543.5147.32.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5411bc3d-74eb-6868-5768-bba3726a661a@linux.microsoft.com>
Date:   Thu, 9 Jan 2020 08:38:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578545543.5147.32.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/8/20 8:52 PM, Mimi Zohar wrote:

> 
> For the time being, I've pushed out this patch with the existing patch
> description to next-integrity-testing, but the patch description
> should be rewritten clearer.  For example,
> 
> As a result of the asymmetric public keys subtype being defined as a
> tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
> be built as a kernel module.  To prevent this from happening, this
> patch defines and uses an intermediate Kconfig boolean option named
> IMA_MEASURE_ASYMMETRIC_KEYS.
> 
> Please let me know if you're ok with this wording.
> 
> thanks,
> 
> Mimi
> 

That sounds perfect. Thanks for your help Mimi.

  -lakshmi
