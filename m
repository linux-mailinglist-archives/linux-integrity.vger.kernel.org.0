Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF57823C2EB
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHEBOl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 21:14:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42320 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHEBOl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 21:14:41 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7C12820B4908;
        Tue,  4 Aug 2020 18:14:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C12820B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596590080;
        bh=pB9tfJI+Mi5/kik0aQ3aA0nv5uOOIUeHWkkSk/Xfujo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EbI78P7aDi5mfRJqIsbxK5gSUDMZJRJp/gj2DLzS10v74xXb4N4dR9l+KIT+gaRM5
         CJBMkGNUsbZ+OoWuW/9qBMwGJ8DYiXCz6/6XcxRM6YrDhOn3Z0+jRiT1fQOW8LLDI5
         EeSAg0z5plYEDTyUOIy9vOOnUMnF1ZdmyRhRk+/8=
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        stephen.smalley.work@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
Date:   Tue, 4 Aug 2020 18:14:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/20 6:04 PM, Casey Schaufler wrote:
> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
>> Critical data structures of security modules are currently not measured.
>> Therefore an attestation service, for instance, would not be able to
>> attest whether the security modules are always operating with the policies
>> and configuration that the system administrator had setup. The policies
>> and configuration for the security modules could be tampered with by
>> malware by exploiting kernel vulnerabilities or modified through some
>> inadvertent actions on the system. Measuring such critical data would
>> enable an attestation service to better assess the state of the system.
> 
> I still wonder why you're calling this an LSM change/feature when
> all the change is in IMA and SELinux. You're not putting anything
> into the LSM infrastructure, not are you using the LSM infrastructure
> to achieve your ends. Sure, you *could* support other security modules
> using this scheme, but you have a configuration dependency on
> SELinux, so that's at best going to be messy. If you want this to
> be an LSM "feature" you need to use the LSM hooking mechanism.

> 
> I'm not objecting to the feature. It adds value. But as you've
> implemented it it is either an IMA extension to SELinux, or an
> SELiux extension to IMA. Could AppArmor add hooks for this without
> changing the IMA code? It doesn't look like it to me.

The check in IMA to allow the new IMA hook func LSM_STATE and LSM_POLICY 
when SELinux is enabled is just because SELinux is the only security 
module using these hooks now.

To enable AppArmor, for instance, to use the new IMA hooks to measure 
state and policy would just require adding the check for 
CONFIG_SECURITY_APPARMOR. Other than that, there are no IMA changes 
needed to support AppArmor or other such security modules.

Please see Patch 1/4

+			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
+				 strcmp(args[0].from, "LSM_STATE") == 0)
+				entry->func = LSM_STATE;
+			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
+				 strcmp(args[0].from, "LSM_POLICY") == 0)
+				entry->func = LSM_POLICY;

And, if early boot measurement is needed for AppArmor the following 
change in IMA's Kconfig

Patch 4/4

+config IMA_QUEUE_EARLY_BOOT_DATA
  	bool
+	depends on SECURITY_SELINUX || (IMA_MEASURE_ASYMMETRIC_KEYS && 
SYSTEM_TRUSTED_KEYRING)
  	default y

If you think calling this an "LSM feature" is not appropriate, please 
suggest a better phrase.

But like I said above, with minimal change in IMA other security modules 
can be supported to measure STATE and POLICY data.

  -lakshmi


