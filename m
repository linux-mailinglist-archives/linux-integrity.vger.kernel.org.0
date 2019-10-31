Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F6EB406
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJaPgE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfJaPgE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:36:04 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD632086D;
        Thu, 31 Oct 2019 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572536163;
        bh=AbvQStO4mftxwOLZ6Vl8wEv4VUDwqs8YdcH3DMqFFYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgK0nkFL/OFf39EmgXyG/cwq07tF9zrAreYfzEZ96SVGFKha6hnCKad0/aaVbdJ+l
         DiTmvprYSSf1qmHgsy1CNs0dW2uNwTc9ki2AMyLcuQEeTQDVdiqNYznTyttAYf6SQZ
         Ug1rsN0rcIK7euU0dn26eb8hJ6iD4r6Fbi52ufKg=
Date:   Thu, 31 Oct 2019 11:36:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
Message-ID: <20191031153600.GR1554@sasha-vm>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <20191031091041.GO1554@sasha-vm>
 <af591616-ac80-c862-6822-d11addeabb91@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <af591616-ac80-c862-6822-d11addeabb91@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 31, 2019 at 08:27:47AM -0700, Lakshmi Ramasubramanian wrote:
>On 10/31/19 2:10 AM, Sasha Levin wrote:
>
>Hi Sasha,
>
>>On Wed, Oct 30, 2019 at 06:19:02PM -0700, Lakshmi Ramasubramanian wrote:
>>>Asymmetric keys used for verifying file signatures or certificates
>>>are currently not included in the IMA measurement list.
>>>
>>>This patch defines a new IMA hook namely ima_post_key_create_or_update()
>>>to measure asymmetric keys.
>>>
>>>Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>>What are the prerequisites for this patch?
>
>I built this patch set on kernel v5.3
>
>I applied the following patch provided by Nayna Jain@IBM and then 
>added my changes:
>
>	[PATCH v9 5/8] ima: make process_buffer_measurement() generic

$ git checkout v5.3
HEAD is now at 4d856f72c10ec Linux 5.3
$ git am ~/incoming/_PATCH_v9_5-8_ima_make_process_buffer_measurement__generic.patch
Applying: ima: make process_buffer_measurement() generic
error: patch failed: security/integrity/ima/ima.h:217
error: security/integrity/ima/ima.h: patch does not apply

What am I missing?

-- 
Thanks,
Sasha
