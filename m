Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFF2C1493
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 20:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgKWThu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 14:37:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43592 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgKWTht (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 14:37:49 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 999C720B717A;
        Mon, 23 Nov 2020 11:37:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 999C720B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606160269;
        bh=nKE9ax347McNMh2dmVuxCHdA60lE1Lj1JfhVD8MiYHg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gQt1e+OQTP6YHmycUCZNsLBZ5DpexXnLF946JnOKKBsGiIGRldemKi+3Vi+rPJQxU
         puJnpgUGzmgK6b5l0gZAudPAZe+5UhD0Di5yzUMOaL00REoPCK+iUpJjtDH8AGyGew
         YdSpUpMRjoTjlyo4VQKQClPH1t7jXW2OwHOCL3fw=
Subject: Re: [PATCH v6 8/8] selinux: measure state and hash of the policy
 using IMA
To:     James Morris <jmorris@namei.org>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com,
        tyhicks@linux.microsoft.com, sashal@kernel.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201119232611.30114-9-tusharsu@linux.microsoft.com>
 <alpine.LRH.2.21.2011211301340.18334@namei.org>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <33718d39-a3a2-595b-46b0-f1a195348000@linux.microsoft.com>
Date:   Mon, 23 Nov 2020 11:37:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2011211301340.18334@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On 2020-11-20 6:05 p.m., James Morris wrote:
> On Thu, 19 Nov 2020, Tushar Sugandhi wrote:
> 
>> an impact on the security guarantees provided by SELinux. Measuring
>> such in-memory data structures through IMA subsystem provides a secure
>> way for a remote attestation service to know the state of the system
>> and also the runtime changes in the state of the system.
> 
> I think we need better clarity on the security model here than just "a
> secure way...".  Secure how and against what threats?
> 
Thanks for taking a look at this patch series.

Here is the overall threat model:

For a given device inside an organization, various services/
infrastructure tools owned by the org interact with the device. These
services/tools can be external to the device. They can interact with the
device both during setup and rest of the device lifetime. These
interactions may involve sharing the org sensitive data and/or running
business critical workload on that device. Before sharing data/running
workload on that device - the org would want to know the security
profile of the device. E.g. SELinux is enforced (with the policy that is
expected by the org), disks are encrypted with a certain configuration,
secure boot is enabled etc. If the org requirements are satisfied, then
only the external services will start interacting with the device.

For the org, extracting that information from the device is tricky.
The services could look for some markers on the device necessary to
satisfy the org requirements. But the device could already be
compromised with some malware, and could simply lie to the external
services by putting false markers on the device. For instance, the
malware can put a random SELinux policy file at the expected location
even when SELinux is not even enabled on the device.

If the org trusts these false markers, the compromised device could go
undetected - and can do further damage once it has access to the org
sensitive data / business critical processes.

This is the threat we are trying to address.

For the org, to address this threat - at least three things are needed:

(1) Producers of the markers are as close to the source as possible:
The source that does the work of actually protecting the device.
E.g. SELinux state reported from the SELinux kernel LVM itself, rather
than some user mode process extracting that information).
This will make it harder for the bad actors to mimic the information -
thus reducing the ROI for them.

(2) Extracting the information from the device in a tamper resistant
way:
Even if the information is produced by the expected source, it can still
get altered by attackers. This can happen before the info reaches the
external services - the services that make the decision whether to trust
the device with org sensitive info or not.
The IMA measurement infrastructure, with TPM extend and quoting,
provides the necessary assurance to those services - that the
information coming from the device is not tampered with.

(3) Tracking the state change during the lifetime of the device:
The device may start in a good configuration. But over the lifetime,
that configuration may deteriorate. E.g. SELinux stores the
current operating mode, in memory, which could be "enforce" or "audit".
Changes to this data at runtime impacts the security guarantees provided
by SELinux. Such changes could be made inadvertently or by malware
running on the device.


The IMA hook plus policies in the first 7/8 patches provide the
necessary functionality to achieve (2).

The last SELinux 8/8 patch helps achieve (1).

And the patches in the series overall work together to achieve (3).

> This looks to me like configuration assurance, i.e. you just want to know
> that systems have been configured correctly, not to detect a competent
> attack. Is that correct?

The attestation service would look at various measurements coming from
the device. And there could be a discrepancy between the measurements,
or the measurements won't match the expected predetermined values. In
that case, the attestation service may conclude that not only the device
is misconfigured, but also that misconfiguration is a result of
potentially compromised device. Then the necessary action can be taken
for the device (removing it from the network, not sharing data/workload
with it etc.)

~Tushar
