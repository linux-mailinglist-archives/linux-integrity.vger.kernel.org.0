Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317062336DE
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgG3QdJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 12:33:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38782 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3QdJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 12:33:09 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24CBE20B4908;
        Thu, 30 Jul 2020 09:33:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24CBE20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596126788;
        bh=CXrOFE5NrIuJnLNGlIHi4t8xRkLX9SQCgHFckqGA1wQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fap1IyJqn1hH6EVgx2Gkat3pIMfUkd4uIXgLtXsTdICaIFNd6nprt9FUMmozk4pqA
         AtwgFvr2ILNnBVSVRXFLvD2grw3pn/Whmzxf2UyAXig86VuVN/jJ5/vIwA04uxXMuv
         Rt3ofhkCgRVqJGV9Y0WwZjfwrQ3MYt84B5p2AzIw=
Subject: Re: [PATCH v5 1/4] IMA: Add func to measure LSM state and policy
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-2-nramas@linux.microsoft.com>
 <20200730150228.GV4181@sequoia>
 <b4428195-7a68-365d-a792-2855609c2221@schaufler-ca.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1819121c-bc76-2414-a8e1-8bfd1c014d6b@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 09:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b4428195-7a68-365d-a792-2855609c2221@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/30/20 9:19 AM, Casey Schaufler wrote:

>>> Critical data structures of security modules need to be measured to
>>> enable an attestation service to verify if the configuration and
>>> policies for the security modules have been setup correctly and
>>> that they haven't been tampered with at runtime. A new IMA policy is
>>> required for handling this measurement.
>>>
>>> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
>>> measure the state and the policy provided by the security modules.
> 
> If, as you suggest below, this is SELinux specific,
> these should be SELINUX_STATE and SELINUX_POLICY.
> It makes me very uncomfortable when I see LSM used
> in cases where SELinux is required. The LSM is supposed
> to be an agnostic interface, so if you need to throw
> 
> 	if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> 
> into the IMA code you're clearly not thinking in terms
> of the LSM layer. I have no problem with seeing SELinux
> oriented and/or specific code in IMA if that's what you want.
> Just don't call it LSM.

The hook defined in IMA is not SELinux specific - it is generic enough 
to be used by any security module to measure their STATE and POLICY.

I have implemented the measurement for SELinux to illustrate the usage.

Tyler's suggestion was to allow this IMA policy only when component(s) 
that are using it are also enabled.

  -lakshmi


