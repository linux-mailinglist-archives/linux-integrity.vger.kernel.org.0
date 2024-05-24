Return-Path: <linux-integrity+bounces-2625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D708CEB12
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196E11F221CC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB412EBE6;
	Fri, 24 May 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p+lezVSi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209C84DF5;
	Fri, 24 May 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583620; cv=none; b=dMM7eYc7vQKOYJjPrDPqEhjNFoWof0qecipqdxvPToG9fS0cCtSv/byU7D8sB1b2nv37ivxZ6em7mccytXvf4QYtt25WU9SC1r54VlA1orpGfl9FSZC4p214Ck4Wc2yXe7fXGeaD315dPdCqnosPBa4ic9fYa3bTh7Qm0UjezUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583620; c=relaxed/simple;
	bh=VZkXko4Fp6TPTvkkOQ5ECkH8nXiUQiz+x69L2SdEnBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hvgehqd9PmfDiXApasX+UnsYg9hNQn+9jjuRTk2AzgzQxyPPgNM6cR060cCTDddxu/8VPC0UIXAZhA2kIx04JcH/w842OTzIfGYYS3OOrjg5L5KCnvhULDN5K1Wg18S7hEmMvRSYZ72ah67gFEnSqf9ZuYwkw2ikdSZy5SjYJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p+lezVSi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 22CAC2067B48; Fri, 24 May 2024 13:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22CAC2067B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716583611;
	bh=aOTKnJd5r90KSzLZEsdl9C1z9XF+W5S+LazfbW7kb84=;
	h=From:To:Cc:Subject:Date:From;
	b=p+lezVSimhOlbMpu1Brtw6EFhAlmrXKm0mtWcBIuR7Yxo2WpomcV6ByFB1+uUhy5M
	 HdxK7lRSy/+IJgfF+XKKTY7S8sdcD+04aGgHb5AqQBZEqvQOSMEw8gHXZadlEf3BRc
	 669C6td4JTF054yZUMri8OJQafqGUF0qp8qnoZWw=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v19 00/20] Integrity Policy Enforcement LSM (IPE)
Date: Fri, 24 May 2024 13:46:29 -0700
Message-Id: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

IPE is a Linux Security Module that takes a complementary approach to
access control. Unlike traditional access control mechanisms that rely on
labels and paths for decision-making, IPE focuses on the immutable security
properties inherent to system components. These properties are fundamental
attributes or features of a system component that cannot be altered,
ensuring a consistent and reliable basis for security decisions.

To elaborate, in the context of IPE, system components primarily refer to
files or the devices these files reside on. However, this is just a
starting point. The concept of system components is flexible and can be
extended to include new elements as the system evolves. The immutable
properties include the origin of a file, which remains constant and
unchangeable over time. For example, IPE policies can be crafted to trust
files originating from the initramfs. Since initramfs is typically verified
by the bootloader, its files are deemed trustworthy; "file is from
initramfs" becomes an immutable property under IPE's consideration.

The immutable property concept extends to the security features enabled on
a file's origin, such as dm-verity or fs-verity, which provide a layer of
integrity and trust. For example, IPE allows the definition of policies
that trust files from a dm-verity protected device. dm-verity ensures the
integrity of an entire device by providing a verifiable and immutable state
of its contents. Similarly, fs-verity offers filesystem-level integrity
checks, allowing IPE to enforce policies that trust files protected by
fs-verity. These two features cannot be turned off once established, so
they are considered immutable properties. These examples demonstrate how
IPE leverages immutable properties, such as a file's origin and its
integrity protection mechanisms, to make access control decisions.

For the IPE policy, specifically, it grants the ability to enforce
stringent access controls by assessing security properties against
reference values defined within the policy. This assessment can be based on
the existence of a security property (e.g., verifying if a file originates
from initramfs) or evaluating the internal state of an immutable security
property. The latter includes checking the roothash of a dm-verity
protected device, determining whether dm-verity possesses a valid
signature, assessing the digest of a fs-verity protected file, or
determining whether fs-verity possesses a valid built-in signature. This
nuanced approach to policy enforcement enables a highly secure and
customizable system defense mechanism, tailored to specific security
requirements and trust models.

IPE is compiled under CONFIG_SECURITY_IPE.

Use Cases
---------

IPE works best in fixed-function devices: Devices in which their purpose
is clearly defined and not supposed to be changed (e.g. network firewall
device in a data center, an IoT device, etcetera), where all software and
configuration is built and provisioned by the system owner.

IPE is a long-way off for use in general-purpose computing: the Linux
community as a whole tends to follow a decentralized trust model,
known as the web of trust, which IPE has no support for as of  yet.
There are exceptions, such as the case where a Linux distribution
vendor trusts only their own keys, where IPE can successfully be used
to enforce the trust requirement.

Additionally, while most packages are signed today, the files inside
the packages (for instance, the executables), tend to be unsigned. This
makes it difficult to utilize IPE in systems where a package manager is
expected to be functional, without major changes to the package manager
and ecosystem behind it.

The digest_cache LSM[1] is a system that when combined with IPE, could be
used to enable general purpose computing scenarios.

Policy
-------

IPE policy is a plain-text policy composed of multiple statements
over several lines. There is one required line, at the top of the
policy, indicating the policy name, and the policy version, for
instance:

  policy_name=Ex_Policy policy_version=0.0.0

The policy version indicates the current version of the policy. This is
used to prevent roll-back of policy to potentially insecure previous
versions of the policy.

The next portion of IPE policy, are rules. Rules are formed by key=value
pairs, known as properties. IPE rules require two keys: "action", which
determines what IPE does when it encounters a match against the policy
and "op", which determines when that rule should be evaluated.

Thus, a minimal rule is:

  op=EXECUTE action=ALLOW

This example rule will allow any execution. A rule is required to have the
"op" property as the first token of a rule, and the "action" as the last
token of the rule.

Additional properties are used to assess immutable security properties
about the files being evaluated. These properties are intended to be
deterministic attributes that are resident in the kernel.

For example:

  op=EXECUTE dmverity_signature=FALSE action=DENY

This rule with property dmverity_signature will deny any file not from
a signed dmverity volume to be executed.

All available properties for IPE described in the documentation patch of
this series.

Rules are evaluated top-to-bottom. As a result, any revocation rules,
or denies should be placed early in the file to ensure that these rules
are evaluated before a rule with "action=ALLOW" is hit.

Any unknown syntax in IPE policy will result in a fatal error to parse
the policy.

Additionally, a DEFAULT operation must be set for all understood
operations within IPE. For policies to remain completely forwards
compatible, it is recommended that users add a "DEFAULT action=ALLOW"
and override the defaults on a per-operation basis.

For more information about the policy syntax, see the kernel
documentation page.

Early Usermode Protection
--------------------------

IPE can be provided with a policy at startup to load and enforce.
This is intended to be a minimal policy to get the system to a state
where userspace is setup and ready to receive commands, at which
point a policy can be deployed via securityfs. This "boot policy" can be
specified via the config, SECURITY_IPE_BOOT_POLICY, which accepts a path
to a plain-text version of the IPE policy to apply. This policy will be
compiled into the kernel. If not specified, IPE will be disabled until a
policy is deployed and activated through the method above.

Policy Examples
----------------

Allow all:

  policy_name=Allow_All policy_version=0.0.0
  DEFAULT action=ALLOW

Allow only initramfs:

  policy_name=Allow_Initramfs policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW

Allow any signed and validated dm-verity volume and the initramfs:

  policy_name=Allow_Signed_DMV_And_Initramfs policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Prohibit execution from a specific dm-verity volume, while allowing
all signed volumes and the initramfs:

  policy_name=Deny_DMV_By_Roothash policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=sha256:cd2c5bae7c6c579edaae4353049d58eb5f2e8be0244bf05345bc8e5ed257baff action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Allow only a specific dm-verity volume:

  policy_name=Allow_DMV_By_Roothash policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=sha256:401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW

Allow any fs-verity file with a valid built-in signature:

  policy_name=Allow_Signed_And_Validated_FSVerity policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE fsverity_signature=TRUE action=ALLOW

Allow execution of a specific fs-verity file:

  policy_name=ALLOW_FSV_By_Digest policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE fsverity_digest=sha256:fd88f2b8824e197f850bf4c5109bea5cf0ee38104f710843bb72da796ba5af9e action=ALLOW

Deploying Policies
-------------------

First sign a plain text policy, with a certificate that is present in
the SYSTEM_TRUSTED_KEYRING of your test machine. Through openssl, the
signing can be done via:

  openssl smime -sign -in "$MY_POLICY" -signer "$MY_CERTIFICATE" \
    -inkey "$MY_PRIVATE_KEY" -outform der -noattr -nodetach \
    -out "$MY_POLICY.p7s"

Then, simply cat the file into the IPE's "new_policy" securityfs node:

  cat "$MY_POLICY.p7s" > /sys/kernel/security/ipe/new_policy

The policy should now be present under the policies/ subdirectory, under
its "policy_name" attribute.

The policy is now present in the kernel and can be marked as active,
via the securityfs node:

  echo 1 > "/sys/kernel/security/ipe/$MY_POLICY_NAME/active"

This will now mark the policy as active and the system will be enforcing
$MY_POLICY_NAME.

There is one requirement when marking a policy as active, the policy_version
attribute must either increase, or remain the same as the currently running
policy.

Policies can be updated via:

  cat "$MY_UPDATED_POLICY.p7s" > \
    "/sys/kernel/security/ipe/policies/$MY_POLICY_NAME/update"

Additionally, policies can be deleted via the "delete" securityfs
node. Simply write "1" to the corresponding node in the policy folder:

  echo 1 > "/sys/kernel/security/ipe/policies/$MY_POLICY_NAME/delete"

There is only one requirement to delete policies, the policy being
deleted must not be the active policy.

NOTE: Any securityfs write to IPE's nodes will require CAP_MAC_ADMIN.

Integrations
-------------

This patch series adds support for fsverity via digest and signature
(fsverity_signature and fsverity_digest), dm-verity by digest and
signature (dmverity_signature and dmverity_roothash), and trust for
the initramfs (boot_verified).

Please see the documentation patch for more information about the
integrations available.

Testing
--------

KUnit Tests are available. Recommended kunitconfig:

    CONFIG_KUNIT=y
    CONFIG_SECURITY=y
    CONFIG_SECURITYFS=y
    CONFIG_PKCS7_MESSAGE_PARSER=y
    CONFIG_SYSTEM_DATA_VERIFICATION=y
    CONFIG_FS_VERITY=y
    CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
    CONFIG_BLOCK=y
    CONFIG_MD=y
    CONFIG_BLK_DEV_DM=y
    CONFIG_DM_VERITY=y
    CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
    CONFIG_NET=y
    CONFIG_AUDIT=y
    CONFIG_AUDITSYSCALL=y
    CONFIG_BLK_DEV_INITRD=y

    CONFIG_SECURITY_IPE=y
    CONFIG_IPE_PROP_DM_VERITY=y
    CONFIG_IPE_PROP_DM_VERITY_SIGNATURE=y
    CONFIG_IPE_PROP_FS_VERITY=y
    CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG=y
    CONFIG_SECURITY_IPE_KUNIT_TEST=y

Simply run:

    make ARCH=um mrproper
    ./tools/testing/kunit/kunit.py run --kunitconfig <path/to/config>

And the tests will execute and report the result.

In addition, IPE has a python based integration
test suite https://github.com/microsoft/ipe/tree/test-suite that
can test both user interfaces and enforcement functionalities.

Documentation
--------------

There is both documentation available on github at
https://microsoft.github.io/ipe, and Documentation in this patch series,
to be added in-tree.

Known Gaps
-----------

IPE has two known gaps:

1. IPE cannot verify the integrity of anonymous executable memory, such as
  the trampolines created by gcc closures and libffi (<3.4.2), or JIT'd code.
  Unfortunately, as this is dynamically generated code, there is no way
  for IPE to ensure the integrity of this code to form a trust basis. In all
  cases, the return result for these operations will be whatever the admin
  configures the DEFAULT action for "EXECUTE".

2. IPE cannot verify the integrity of interpreted languages' programs when
  these scripts invoked via ``<interpreter> <file>``. This is because the
  way interpreters execute these files, the scripts themselves are not
  evaluated as executable code through one of IPE's hooks. Interpreters
  can be enlightened to the usage of IPE by trying to mmap a file into
  executable memory (+X), after opening the file and responding to the
  error code appropriately. This also applies to included files, or high
  value files, such as configuration files of critical system components.

Appendix
---------

A. IPE Github Repository: https://github.com/microsoft/ipe
B. IPE Users' Guide: Documentation/admin-guide/LSM/ipe.rst

References
-----------

1: https://lore.kernel.org/lkml/20240415142436.2545003-1-roberto.sassu@huaweicloud.com/

FAQ:
----

Q: What is the difference between IMA and IPE?

A: See the documentation patch for more on this topic.

Previous Postings
-----------------

v1: https://lore.kernel.org/all/20200406181045.1024164-1-deven.desai@linux.microsoft.com/
v2: https://lore.kernel.org/all/20200406221439.1469862-1-deven.desai@linux.microsoft.com/
v3: https://lore.kernel.org/all/20200415162550.2324-1-deven.desai@linux.microsoft.com/
v4: https://lore.kernel.org/all/20200717230941.1190744-1-deven.desai@linux.microsoft.com/
v5: https://lore.kernel.org/all/20200728213614.586312-1-deven.desai@linux.microsoft.com/
v6: https://lore.kernel.org/all/20200730003113.2561644-1-deven.desai@linux.microsoft.com/
v7: https://lore.kernel.org/all/1634151995-16266-1-git-send-email-deven.desai@linux.microsoft.com/
v8: https://lore.kernel.org/all/1654714889-26728-1-git-send-email-deven.desai@linux.microsoft.com/
v9: https://lore.kernel.org/lkml/1675119451-23180-1-git-send-email-wufan@linux.microsoft.com/
v10: https://lore.kernel.org/lkml/1687986571-16823-1-git-send-email-wufan@linux.microsoft.com/
v11: https://lore.kernel.org/lkml/1696457386-3010-1-git-send-email-wufan@linux.microsoft.com/
v12: https://lore.kernel.org/lkml/1706654228-17180-1-git-send-email-wufan@linux.microsoft.com/
v13: https://lore.kernel.org/lkml/1709168102-7677-1-git-send-email-wufan@linux.microsoft.com/
v14: https://lore.kernel.org/lkml/1709768084-22539-1-git-send-email-wufan@linux.microsoft.com/
v15: https://lore.kernel.org/lkml/1710560151-28904-1-git-send-email-wufan@linux.microsoft.com/
v16: https://lore.kernel.org/lkml/1711657047-10526-1-git-send-email-wufan@linux.microsoft.com/
v17: https://lore.kernel.org/lkml/1712969764-31039-1-git-send-email-wufan@linux.microsoft.com/
v18: https://lore.kernel.org/lkml/1714775551-22384-1-git-send-email-wufan@linux.microsoft.com/

Changelog
----------

v2:
  Split the second patch of the previous series into two.
  Minor corrections in the cover-letter and documentation
  comments regarding CAP_MAC_ADMIN checks in IPE.

v3:
  Address various comments by Jann Horn. Highlights:
    Switch various audit allocators to GFP_KERNEL.
    Utilize rcu_access_pointer() in various locations.
    Strip out the caching system for properties
    Strip comments from headers
    Move functions around in patches
    Remove kernel command line parameters
    Reconcile the race condition on the delete node for policy by
      expanding the policy critical section.

  Address a few comments by Jonathan Corbet around the documentation
    pages for IPE.

  Fix an issue with the initialization of IPE policy with a "-0"
    version, caused by not initializing the hlist entries before
    freeing.

v4:
  Address a concern around IPE's behavior with unknown syntax.
    Specifically, make any unknown syntax a fatal error instead of a
    warning, as suggested by Mickaël Salaün.
  Introduce a new securityfs node, $securityfs/ipe/property_config,
    which provides a listing of what properties are enabled by the
    kernel and their versions. This allows usermode to predict what
    policies should be allowed.
  Strip some comments from c files that I missed.
  Clarify some documentation comments around 'boot_verified'.
    While this currently does not functionally change the property
    itself, the distinction is important when IPE can enforce verified
    reads. Additionally, 'KERNEL_READ' was omitted from the documentation.
    This has been corrected.
  Change SecurityFS and SHA1 to a reverse dependency.
  Update the cover-letter with the updated behavior of unknown syntax.
  Remove all sysctls, making an equivalent function in securityfs.
  Rework the active/delete mechanism to be a node under the policy in
    $securityfs/ipe/policies.
  The kernel command line parameters ipe.enforce and ipe.success_audit
    have returned as this functionality is no longer exposed through
    sysfs.

v5:
  Correct some grammatical errors reported by Randy Dunlap.
  Fix some warnings reported by kernel test bot.
  Change convention around security_bdev_setsecurity. -ENOSYS
    is now expected if an LSM does not implement a particular @name,
    as suggested by Casey Schaufler.
  Minor string corrections related to the move from sysfs to securityfs
  Correct a spelling of an #ifdef for the permissive argument.
  Add the kernel parameters re-added to the documentation.
  Fix a minor bug where the mode being audited on permissive switch
    was the original mode, not the mode being swapped to.
  Cleanup doc comments, fix some whitespace alignment issues.

v6:
  Change if statement condition in security_bdev_setsecurity to be
    more concise, as suggested by Casey Schaufler and Al Viro
  Drop the 6th patch in the series, "dm-verity move signature check..."
    due to numerous issues, and it ultimately providing no real value.
  Fix the patch tree - the previous iteration appears to have been in a
    torn state (patches 8+9 were merged). This has since been corrected.

v7:
  * Reword cover letter to more accurate convey IPE's purpose
    and latest updates.
  * Refactor series to:
      1. Support a context structure, enabling:
          1. Easier Testing via KUNIT
          2. A better architecture for future designs
      2. Make parser code cleaner
  * Move patch 01/12 to [14/16] of the series
  * Split up patch 02/12 into four parts:
      1. context creation [01/16]
      2. audit [07/16]
      3. evaluation loop [03/16]
      4. access control hooks [05/16]
      5. permissive mode [08/16]
  * Split up patch 03/12 into two parts:
      1. parser [02/16]
      2. userspace interface [04/16]
  * Reword and refactor patch 04/12 to [09/16]
  * Squash patch 05/12, 07/12, 09/12 to [10/16]
  * Squash patch 08/12, 10/12 to [11/16]
  * Change audit records to MAC region (14XX) from Integrity region (18XX)
  * Add FSVerity Support
  * Interface changes:
      1. "raw" was renamed to "pkcs7" and made read only
      2. "raw"'s write functionality (update a policy) moved to "update"
      3. introduced "version", "policy_name" nodes.
      4. "content" renamed to "policy"
      5. The boot policy can now be updated like any other policy.
  * Add additional developer-level documentation
  * Update admin-guide docs to reflect changes.
  * Kunit tests
  * Dropped CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH - functionality can
    easily come later with a small patch.
  * Use partition0 for block_device for dm-verity patch

v8:
  * Add changelog information to individual commits
  * A large number of changes to the audit patch.
  * split fs/ & security/ changes to two separate patches.
  * split block/, security/ & drivers/md/ changes to separate patches.
  * Add some historical context to what lead to the creation of IPE
    in the documentation patch.
  * Cover-letter changes suggested by Roberto Sassu.

v9:
  * Rewrite IPE parser to use kernel match_table parser.
  * Adapt existing IPE properties to the new parser.
  * Remove ipe_context, quote policy syntax, kernel_read for simplicity.
  * Add new function in the security file system to delete IPE policy.
  * Make IPE audit builtin and change several audit formats.
  * Make boot_verified property builtin

v10:
  * Address various code style/format issues
  * Correct the rcu locking for active policy
  * Fix memleak bugs in the parser, optimize the parser per upstream feedback
  * Adding new audit events for IPE and update audit formats
  * Make the dmverity property auto selected
  * Adding more context in the commit messages

v11:
  * Address various code style/format issues
  * Add finalize hook to device mapper
  * move the security hook for dm-verity to the new device mapper finalize hook

v12:
  * Address locking issues
  * Change the implementation of boot_verified to trust initramfs only
  * Update audit format for IPE decision events
  * Refactor code for lsm_id
  * Add IPE test suite link

v13:
  * Rename the new security hook in initramfs
  * Make the policy grammar independent of kernel config
  * Correct IPE audit format
  * Refactor policy update code

v14:
  * Add more code comments/docs for dmverity/fsverity
  * Fix incorrect code usage and format in dmverity
  * Drop one accepted commit of dmverity

v15:
  * Fix grammar issues
  * Add more documentation to fsverity
  * Switch security hooks from *_setsecurity() to *_setintegrity()
  * Cleanup unnecessary headers

v16:
  * Fix format issues, refactor names
  * Further improve documentation for fsverity
  * Fix bugs in dmverity implementation
  * Switch to use call_int_hook() for *_setintegrity()

v17:
  * Fix various code/Documentation style issues
  * Switch to use reverse christmas tree style
  * add ipe_ prefix to all non-static functions
  * Correct documentation for fsverity
  * Rewrite design concept part of IPE Documentation
  * Fix incorrect interface path in IPE Documentation

v18:
  * Add two new kconfigs and make them auto-selected
  * Fix incorrect error handling and switch to use crypto_ahash_alg_name() in dmverity
  * Move the inode_setintegrity hook call into fsverity_verify_signature() in fsverity
  * Fix typos and cleanup unnecessary code
  * Improve policy examples inside documentation
  * Remove insecure hash algorithms and adapt the documentation accordingly
  * Update the documentation regarding the new Kconfig switches

v19:
  * Drop the finalize dm callback and switch to preresume callback for dm-verity
  * Adding NULL check before kmemdup dm-verity roothash signature
  * Refactor inode_setintegrity hook and cleanup related code
  * Fix documentation warning and format issues

Deven Bowers (13):
  security: add ipe lsm
  ipe: add policy parser
  ipe: add evaluation loop
  ipe: add LSM hooks on execution and kernel read
  ipe: add userspace interface
  uapi|audit|ipe: add ipe auditing support
  ipe: add permissive toggle
  block,lsm: add LSM blob and new LSM hooks for block device
  dm verity: expose root hash digest and signature data to LSMs
  ipe: add support for dm-verity as a trust provider
  scripts: add boot policy generation program
  ipe: kunit test for parser
  Documentation: add ipe documentation

Fan Wu (7):
  initramfs|security: Add a security hook to do_populate_rootfs()
  ipe: introduce 'boot_verified' as a trust provider
  security: add new securityfs delete function
  security: add security_inode_setintegrity() hook
  fsverity: expose verified fsverity built-in signatures to LSMs
  ipe: enable support for fs-verity as a trust provider
  MAINTAINERS: ipe: add ipe maintainer information

 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/ipe.rst         | 792 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  12 +
 Documentation/filesystems/fsverity.rst        |  27 +-
 Documentation/security/index.rst              |   1 +
 Documentation/security/ipe.rst                | 446 ++++++++++
 MAINTAINERS                                   |  10 +
 block/bdev.c                                  |   7 +
 drivers/md/dm-verity-target.c                 | 108 +++
 drivers/md/dm-verity.h                        |   6 +
 fs/verity/signature.c                         |  18 +-
 include/linux/blk_types.h                     |   3 +
 include/linux/lsm_hook_defs.h                 |   9 +
 include/linux/lsm_hooks.h                     |   1 +
 include/linux/security.h                      |  53 ++
 include/uapi/linux/audit.h                    |   3 +
 include/uapi/linux/lsm.h                      |   1 +
 init/initramfs.c                              |   3 +
 scripts/Makefile                              |   1 +
 scripts/ipe/Makefile                          |   2 +
 scripts/ipe/polgen/.gitignore                 |   2 +
 scripts/ipe/polgen/Makefile                   |   5 +
 scripts/ipe/polgen/polgen.c                   | 145 ++++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/inode.c                              |  25 +
 security/ipe/.gitignore                       |   2 +
 security/ipe/Kconfig                          |  97 +++
 security/ipe/Makefile                         |  31 +
 security/ipe/audit.c                          | 279 ++++++
 security/ipe/audit.h                          |  19 +
 security/ipe/digest.c                         | 118 +++
 security/ipe/digest.h                         |  26 +
 security/ipe/eval.c                           | 394 +++++++++
 security/ipe/eval.h                           |  70 ++
 security/ipe/fs.c                             | 247 ++++++
 security/ipe/fs.h                             |  16 +
 security/ipe/hooks.c                          | 315 +++++++
 security/ipe/hooks.h                          |  52 ++
 security/ipe/ipe.c                            |  99 +++
 security/ipe/ipe.h                            |  26 +
 security/ipe/policy.c                         | 229 +++++
 security/ipe/policy.h                         |  98 +++
 security/ipe/policy_fs.c                      | 470 +++++++++++
 security/ipe/policy_parser.c                  | 556 ++++++++++++
 security/ipe/policy_parser.h                  |  11 +
 security/ipe/policy_tests.c                   | 296 +++++++
 security/security.c                           | 122 ++-
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 49 files changed, 5260 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/ipe.rst
 create mode 100644 Documentation/security/ipe.rst
 create mode 100644 scripts/ipe/Makefile
 create mode 100644 scripts/ipe/polgen/.gitignore
 create mode 100644 scripts/ipe/polgen/Makefile
 create mode 100644 scripts/ipe/polgen/polgen.c
 create mode 100644 security/ipe/.gitignore
 create mode 100644 security/ipe/Kconfig
 create mode 100644 security/ipe/Makefile
 create mode 100644 security/ipe/audit.c
 create mode 100644 security/ipe/audit.h
 create mode 100644 security/ipe/digest.c
 create mode 100644 security/ipe/digest.h
 create mode 100644 security/ipe/eval.c
 create mode 100644 security/ipe/eval.h
 create mode 100644 security/ipe/fs.c
 create mode 100644 security/ipe/fs.h
 create mode 100644 security/ipe/hooks.c
 create mode 100644 security/ipe/hooks.h
 create mode 100644 security/ipe/ipe.c
 create mode 100644 security/ipe/ipe.h
 create mode 100644 security/ipe/policy.c
 create mode 100644 security/ipe/policy.h
 create mode 100644 security/ipe/policy_fs.c
 create mode 100644 security/ipe/policy_parser.c
 create mode 100644 security/ipe/policy_parser.h
 create mode 100644 security/ipe/policy_tests.c

--
2.44.0


