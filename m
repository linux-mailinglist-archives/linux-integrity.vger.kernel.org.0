Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F20EB3E0
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfJaP1e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfJaP1e (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:27:34 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC7620873;
        Thu, 31 Oct 2019 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572535653;
        bh=+yVZ1MjIGAdWwgwwfL8MAh8Z053rKZd9qegV46RGdoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAHP+83SfGYxiTmv7PduCRvKVUCHWGYmqh5FQAzyAv4HTcZASqjRHoGCFIU23INqG
         uZi0J4/VSFeOL63l83GmPejEx2UVwEfaEmISV3bKXx6FKwLp9CbBtlX1OAa2CFTIs2
         llGGloPfo1CWC2oBqX/PRTrBbJtN/zXSVI+T7Ivo=
Date:   Thu, 31 Oct 2019 11:27:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
Message-ID: <20191031152730.GQ1554@sasha-vm>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <1572523831.5028.43.camel@linux.ibm.com>
 <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 31, 2019 at 08:08:48AM -0700, Lakshmi Ramasubramanian wrote:
>On 10/31/19 5:10 AM, Mimi Zohar wrote:
>
>>On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
>>>Asymmetric keys used for verifying file signatures or certificates
>>>are currently not included in the IMA measurement list.
>>>
>>>This patch defines a new IMA hook namely ima_post_key_create_or_update()
>>>to measure asymmetric keys.
>>
>>It's not enough for the kernel to be able to compile the kernel after
>>applying all the patches in a patch set.  After applying each patch,
>>the kernel should build properly, otherwise it is not bi-sect safe.
>>  Refer to "3) Separate your changes" of
>>"Documentation/process/submitting-patches.rst.
>
>I started with kernel version 5.3 for this patch set.
>I applied Nayna's process_buffer_measurement() patch and then built my 
>changes on top of that.
>This patch has no other dependency as far as I know.
>
>Are you seeing a build break after applying this patch alone?
>
>(PATCH v3 1/9) KEYS: Defined an IMA hook to measure keys on key create 
>or update

I couldn't even apply this patch: Nayna's series (v10) doesn't apply on
top of 5.3 to begin with, and while it does apply on mainline, this
first patch wouldn't apply on top.

-- 
Thanks,
Sasha
