Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380C1CC9AD
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2020 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEJJ2W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 May 2020 05:28:22 -0400
Received: from smtp-8fad.mail.infomaniak.ch ([83.166.143.173]:54529 "EHLO
        smtp-8fad.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgEJJ2W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 May 2020 05:28:22 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49Kdz73c83zlhlbf;
        Sun, 10 May 2020 11:28:19 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49Kdz52pvmzmgvLW;
        Sun, 10 May 2020 11:28:17 +0200 (CEST)
Subject: Re: [RFC PATCH v3 00/12] Integrity Policy Enforcement LSM (IPE)
To:     deven.desai@linux.microsoft.com, agk@redhat.com, axboe@kernel.dk,
        snitzer@redhat.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b07ac7e1-7cf5-92c9-81d0-64174c3d5024@digikod.net>
Date:   Sun, 10 May 2020 11:28:16 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 15/04/2020 18:25, deven.desai@linux.microsoft.com wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Overview:
> ------------------------------------
> 
> IPE is a Linux Security Module which allows for a configurable
> policy to enforce integrity requirements on the whole system. It
> attempts to solve the issue of Code Integrity: that any code being
> executed (or files being read), are identical to the version that
> was built by a trusted source.
> 
> The type of system for which IPE is designed for use is an embedded device
> with a specific purpose (e.g. network firewall device in a data center),
> where all software and configuration is built and provisioned by the owner.
> 
> Specifically, a system which leverages IPE is not intended for general
> purpose computing and does not utilize any software or configuration
> built by a third party. An ideal system to leverage IPE has both mutable
> and immutable components, however, all binary executable code is immutable.
> 
> The scope of IPE is constrained to the OS. It is assumed that platform
> firmware verifies the the kernel and optionally the root filesystem (e.g.
> via U-Boot verified boot). IPE then utilizes LSM hooks to enforce a
> flexible, kernel-resident integrity verification policy.
> 
> IPE differs from other LSMs which provide integrity checking (for instance,
> IMA), as it has no dependency on the filesystem metadata itself. The
> attributes that IPE checks are deterministic properties that exist solely
> in the kernel. Additionally, IPE provides no additional mechanisms of
> verifying these files (e.g. IMA Signatures) - all of the attributes of
> verifying files are existing features within the kernel, such as dm-verity
> or fsverity.
> 
> IPE provides a policy that allows owners of the system to easily specify
> integrity requirements and uses dm-verity signatures to simplify the
> authentication of allowed objects like authorized code and data.
> 
> IPE supports two modes, permissive (similar to SELinux's permissive mode)
> and enforce. Permissive mode performs the same checks, and logs policy
> violations as enforce mode, but will not enforce the policy. This allows
> users to test policies before enforcing them.
> 
> The default mode is enforce, and can be changed via the kernel commandline
> parameter `ipe.enforce=(0|1)`, or the sysctl `ipe.enforce=(0|1)`. The
> ability to switch modes can be compiled out of the LSM via setting the
> config CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH to N.
> 
> IPE additionally supports success auditing. When enabled, all events
> that pass IPE policy and are not blocked will emit an audit event. This
> is disabled by default, and can be enabled via the kernel commandline
> `ipe.success_audit=(0|1)` or the sysctl `ipe.success_audit=(0|1)`.
> 
> Policies can be staged at runtime through securityfs and activated through
> sysfs. Please see the Deploying Policies section of this cover letter for
> more information.
> 
> The IPE LSM is compiled under CONFIG_SECURITY_IPE.
> 
> Policy:
> ------------------------------------
> 
> IPE policy is designed to be both forward compatible and backwards
> compatible. There is one required line, at the top of the policy,
> indicating the policy name, and the policy version, for instance:
> 
>   policy_name="Ex Policy" policy_version=0.0.0
> 
> The policy version indicates the current version of the policy (NOT the
> policy syntax version). This is used to prevent roll-back of policy to
> potentially insecure previous versions of the policy.
> 
> The next portion of IPE policy, are rules. Rules are formed by key=value
> pairs, known as properties. IPE rules require two properties: "action",
> which determines what IPE does when it encounters a match against the
> policy, and "op", which determines when that rule should be evaluated.
> Thus, a minimal rule is:
> 
>   op=EXECUTE action=ALLOW
> 
> This example will allow any execution. Additional properties are used to
> restrict attributes about the files being evaluated. These properties are
> intended to be deterministic attributes that are resident in the kernel.
> Available properties for IPE described in the properties section of this
> cover-letter, the repository available in Appendix A, and the kernel
> documentation page.
> 
> Order does not matter for the rule's properties - they can be listed in
> any order, however it is encouraged to have the "op" property be first,
> and the "action" property be last, for readability.
> 
> Additionally, rules are evaluated top-to-bottom. As a result, any
> revocation rules, or denies should be placed early in the file to ensure
> that these rules are evaluated before a rule with "action=ALLOW" is hit.
> 
> IPE policy is designed to be forward compatible and backwards compatible,
> thus any failure to parse a rule will result in the line being ignored,
> and a warning being emitted. If backwards compatibility is not required,
> the kernel commandline parameter and sysctl, ipe.strict_parse can be
> enabled, which will cause these warnings to be fatal.

Ignoring unknown command may lead to inconsistent beaviors. To achieve
forward compatibility, I think it would be better to never ignore
unknown rule but to give a way to userspace to known what is the current
kernel ABI. This could be done with a securityfs file listing the
current policy grammar.
