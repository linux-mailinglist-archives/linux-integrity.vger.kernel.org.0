Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD43F8059
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKKTlX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:41:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47794 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfKKTlW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:41:22 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2D8A020B7192;
        Mon, 11 Nov 2019 11:41:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D8A020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573501282;
        bh=yo/9FmZW0Y99bAu6iFa8LVJuZTCyAJDW2GqEslRJ+QQ=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=N2Ewm1z5bz02D6/2tZat1uKI5YJ406Flu+7c+jeChj9D8ThW6vkLp5W/mD56749Ty
         rokrIFXAJvZNzZpBhh47F7UNJRJUmRYv1xL7JEBzXuo1EcrQ851MNXaIV/8ddAp7vH
         cikiSBQ+XvskaHcFyMSN/RNW/oTO6hX1TIc1G1ts=
Subject: Re: [PATCH v5 0/10] KEYS: Measure keys when they are created or
 updated
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Message-ID: <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
Date:   Mon, 11 Nov 2019 11:41:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/11/2019 11:32 AM, Lakshmi Ramasubramanian wrote:

Hi Mimi,

> Problem Statement:
> 
> Keys created or updated in the system are currently not being measured.
> 
> This change aims to address measuring keys created or updated
> in the system:
> 
>    => Patches #1 through #5 update IMA policy functions to handle
>       measurement of keys based on configured IMA policy.
> 
>    => Patches #6 and #7 add IMA hook for measuring keys and the call
>       to the IMA hook from key_create_or_update function.
>       Keys are processed immediately - no support for
>       deferred processing.
> 
>    => Patches #8 through #10 add support for queuing keys if
>       custom IMA policies have not been applied yet and process
>       the queued keys when custom IMA policies are applied.

I was wondering if it'd be better to split this patch set into two sets:

1st set including the patches for measuring keys without queuing support 
(Patches #1 through #7)

2nd set including the patches that add queuing support (Patches #8 
through #10).

thanks,
  -lakshmi
