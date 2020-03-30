Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32CE198133
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgC3Q2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 12:28:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36534 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Q2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 12:28:33 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B5BFD20B46F0;
        Mon, 30 Mar 2020 09:28:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5BFD20B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585585712;
        bh=xpdm1G/x8wAU1J87EOw34JA/g3uzfvRCQbIuW6fHbvg=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=FhNCJ6VtHd/x6h9+wl/Ss/x9hxwH0iOY1V5rJwY1IupLhwapoXqSrsH7ufY4zcuds
         imDgUGxrJfs/WefcN7EnSJ0RlpbQllpfpRY5KTYcW3Iexzv16PPZcvFglZLTI9c0B8
         QtvD2qsqiOe/DlQvd99Ktplsg/7UlfFu+fNaZrLA=
Subject: Re: [PATCH v8 0/2] ima-evm-utils: Add some tests for evmctl
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <d39b433e-4504-d0a4-116f-dd33ca238f7f@linux.microsoft.com>
Message-ID: <0432e72c-4f55-60bd-94c0-13eac1f244d0@linux.microsoft.com>
Date:   Mon, 30 Mar 2020 09:28:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d39b433e-4504-d0a4-116f-dd33ca238f7f@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/30/20 9:16 AM, Lakshmi Ramasubramanian wrote:

> On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
>> This series adds simple evmctl tests for hash, sign, and verify 
>> operations.
> 
> Could you please add the steps to initialize, configure, and run the 
> tests in cover letter?
> 
> thanks,
>   -lakshmi

Sorry - forgot to reply-all.
