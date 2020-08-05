Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365823D201
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 22:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHEUIQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 16:08:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44772 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHEQcf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:35 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3D52C20B490D;
        Wed,  5 Aug 2020 08:45:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D52C20B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596642306;
        bh=XOrG6kgI4euvjYkxWTvPnOcX/802rLfjdEoLoqEaKrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHQbav2mXkHTi6Ep67ltjE6btg+CTQlS1zjS3DUZbnSrPz+em8I0Mfh9p6+RwNJwR
         WE1dCukSVCXnqg6s+eV8D5j2m6FOYPaENcU6t6/gOGuetA28ji5Y578Uft1PaGmKYR
         +TgyWknC9kSWCh8/Y9LX9WDLDrw6vHMyEMmyuQUU=
Date:   Wed, 5 Aug 2020 10:45:04 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
Message-ID: <20200805154504.GB4365@sequoia>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
 <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-08-05 08:36:40, Casey Schaufler wrote:
> On 8/4/2020 6:14 PM, Lakshmi Ramasubramanian wrote:
> > On 8/4/20 6:04 PM, Casey Schaufler wrote:
> >> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
> >>> Critical data structures of security modules are currently not measured.
> >>> Therefore an attestation service, for instance, would not be able to
> >>> attest whether the security modules are always operating with the policies
> >>> and configuration that the system administrator had setup. The policies
> >>> and configuration for the security modules could be tampered with by
> >>> malware by exploiting kernel vulnerabilities or modified through some
> >>> inadvertent actions on the system. Measuring such critical data would
> >>> enable an attestation service to better assess the state of the system.
> >>
> >> I still wonder why you're calling this an LSM change/feature when
> >> all the change is in IMA and SELinux. You're not putting anything
> >> into the LSM infrastructure, not are you using the LSM infrastructure
> >> to achieve your ends. Sure, you *could* support other security modules
> >> using this scheme, but you have a configuration dependency on
> >> SELinux, so that's at best going to be messy. If you want this to
> >> be an LSM "feature" you need to use the LSM hooking mechanism.
> >
> >>
> >> I'm not objecting to the feature. It adds value. But as you've
> >> implemented it it is either an IMA extension to SELinux, or an
> >> SELiux extension to IMA. Could AppArmor add hooks for this without
> >> changing the IMA code? It doesn't look like it to me.
> >
> > The check in IMA to allow the new IMA hook func LSM_STATE and LSM_POLICY when SELinux is enabled is just because SELinux is the only security module using these hooks now.
> >
> > To enable AppArmor, for instance, to use the new IMA hooks to measure state and policy would just require adding the check for CONFIG_SECURITY_APPARMOR. Other than that, there are no IMA changes needed to support AppArmor or other such security modules.
> 
> This is exactly what I'm objecting to. What if a system has both SELinux
> and AppArmor compiled in? What if it has both enabled?

The SELinux state and policy would be measured but the AppArmor
state/policy would be silently ignored. This isn't ideal as the IMA
policy author would need to read the kernel code to figure out which
LSMs are going to be measured.

> 
> >
> > Please see Patch 1/4
> >
> > +            else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> > +                 strcmp(args[0].from, "LSM_STATE") == 0)
> > +                entry->func = LSM_STATE;
> > +            else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> > +                 strcmp(args[0].from, "LSM_POLICY") == 0)
> > +                entry->func = LSM_POLICY;
> >
> > And, if early boot measurement is needed for AppArmor the following change in IMA's Kconfig
> >
> > Patch 4/4
> >
> > +config IMA_QUEUE_EARLY_BOOT_DATA
> >      bool
> > +    depends on SECURITY_SELINUX || (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
> >      default y
> >
> > If you think calling this an "LSM feature" is not appropriate, please suggest a better phrase.
> 
> In the code above you are under CONFIG_SECURITY_SELINUX.
> I would suggest that it's an SELinux feature, so you should
> be using SELINUX_STATE and SELINUX_POLICY, as I suggested
> before. Just because SELinux has state and policy to measure
> doesn't mean that a different module might not have other data,
> such as history, that should be covered as well.

In addition to SELINUX_STATE and SELINUX_POLICY, we should also consider
the proposed LSM_STATE and LSM_POLICY func values but require an "lsm"
rule conditional.

So the current proposed rules:

 measure func=LSM_STATE
 measure func=LSM_POLICY

Would become:

 measure func=LSM_STATE lsm=selinux
 measure func=LSM_POLICY lsm=selinux

The following rules would be rejected:

 measure func=LSM_STATE
 measure func=LSM_POLICY
 measure func=LSM_STATE lsm=apparmor
 measure func=LSM_POLICY lsm=smack

Of course, the apparmor and smack rules could/would be allowed when
proper support is in place.

Tyler

> 
> I realize that IMA already has compile time dependencies to
> determine which xattrs to measure. There's no reason that
> the xattr list couldn't be determined at boot time, with
> each security module providing the XATTR_NAME values it
> uses.
> 
> >
> > But like I said above, with minimal change in IMA other security modules can be supported to measure STATE and POLICY data.
> >
> >  -lakshmi
> >
> >
