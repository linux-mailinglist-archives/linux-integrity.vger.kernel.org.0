Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD191BE51D
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD2RXB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 13:23:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2RXA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 13:23:00 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2070820B4737;
        Wed, 29 Apr 2020 10:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2070820B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588180980;
        bh=dXAt2PJpTkQ9MnX44sOk0KMteaTwRrL51u5353hkQ94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DX66KKJLYlVCgw3mkUmwBYA5r5p9uA0owtBrZiqT/fvRcYj2ij8ej744ulJGGriIP
         M+TtRbsGp1WRXWWOXXaasL/93q3GfwfUdI4zMPJgNFS6mdR881LmoXxWpJMxRDa8sZ
         U8F3tYpm+QUpp1oP42gQw04i0AJhfgXXhXdh67o4=
Subject: Re: [PATCH 2/2] ima: add policy support for the new file open
 MAY_OPENEXEC flag
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mickael Salaun <mic@digikod.net>, Steve Grubb <sgrubb@redhat.com>,
        Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
 <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5c7a4ef6-db0b-431a-b745-987176fa41ed@linux.microsoft.com>
Date:   Wed, 29 Apr 2020 10:22:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/29/20 6:38 AM, Mimi Zohar wrote:
> The kernel has no way of differentiating between a file containing data
> or code being opened by an interpreter.  The proposed RESOLVE_MAYEXEC
> openat2(2) flag bridges this gap by defining and enabling the MAY_OPENEXEC
> flag.
> 
> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> 
> Example:
> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed.

