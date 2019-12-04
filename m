Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7F1137D1
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 23:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLDWoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 17:44:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfLDWoE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 17:44:04 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FC0320BE482;
        Wed,  4 Dec 2019 14:44:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FC0320BE482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575499443;
        bh=6IUNk4Ucj8w6gtQy1jEid7FoUFDc03WlbVxiK/Geq8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jXiBx/p3hqoEt9I8rMoEDAIfYNF7XedjvEBfknuJvB2V5HuurZXlZTRnCWe479VEl
         Crk0zp0+qd4nadLfglt9S6bBod62nQnIsVu8MWY2ZaqKOx0tbAPru1uoMp+WGOhr9B
         6sESv2vxRhXi9TCCzsJjl9nXdRUUBRP1BQY98hAk=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
 <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
 <1575403616.5241.76.camel@linux.ibm.com>
 <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
 <1575458192.5241.99.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2c613462-825e-a3d1-9bf2-2314f0c1a4da@linux.microsoft.com>
Date:   Wed, 4 Dec 2019 14:43:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575458192.5241.99.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/4/19 3:16 AM, Mimi Zohar wrote:

Hi Mimi,

> 
> The integrity subsystem, and other concepts upstreamed to support it,
> are being used by different people/companies in different ways.  I
> know some of the ways, but not all, as how it is being used.  For
> example, Mat Martineau gave an LSS2019-NA talk titled "Using and
> Implementing Keyring Restrictions for Userspace".  I don't know if he
> would be interested in measuring keys on these restricted userspace
> keyrings, but before we limit how a new feature works, we should at
> least look to see if that limitation is really necessary.
> 
> Mimi

I have updated the patch per your suggestion - if uid is specified in 
the policy for key measurement, then it is checked against the current 
user's credential.

Please review the updated patch set (v10).

thanks,
  -lakshmi


