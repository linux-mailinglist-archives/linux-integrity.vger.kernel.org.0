Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C035CCA144
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJCPlB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 11:41:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43428 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJCPlA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 11:41:00 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1323820BBF87;
        Thu,  3 Oct 2019 08:41:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1323820BBF87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570117260;
        bh=VXWU+xxOw4oOE5WPfbmuiZOKkgsS8/j6Ootr6dfT9jw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Eb9g6OOrekVAF2ugx2720Yih9o9gt24mEdkqM9V5W8Mq5dznI1Ingh5jzDQaLL8s6
         lle1nTLXwTfxLV+MYdIu7TBYPXT4ORJn5+ZV+ymzukYKXz2sB7IUFIrHXZ4QGbVVTn
         wPwZoa7WpYPZ+nxQGQROZUcKNlD1rmkQMBXC0XyU=
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
 <1569364624.5364.23.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
Date:   Thu, 3 Oct 2019 08:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569364624.5364.23.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/24/19 3:37 PM, James Bottomley wrote:
> On Tue, 2019-09-24 at 15:31 -0700, Lakshmi Ramasubramanian wrote:
> 
> There has been some discussion that we could, for UEFI systems, use the
> UEFI runtime drivers for the TPM until the actual driver is inserted
> but no-one's looked into doing that.
> 
> James

Can IMA take a dependency on TPM and postpone IMA initialization until a 
TPM device shows up?

Has anyone looked into this?

Thanks,
  -lakshmi


