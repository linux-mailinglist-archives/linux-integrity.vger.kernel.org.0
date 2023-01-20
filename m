Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416E5674E53
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jan 2023 08:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjATHnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 02:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjATHnt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4097DFAC;
        Thu, 19 Jan 2023 23:43:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7ZgXe022648;
        Fri, 20 Jan 2023 07:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FDmZEjIzcBuRMTleCU1btTHjVxahIZaPUSoaEeLBJEM=;
 b=Z8wE+IuId62I1YUbP0S/hn8wZWeU+HEnqrW+2g/XbMkWnVZTMF95F4VOy8XUvXXa3RoH
 uG2lPDFyQlaqg2ahVLtupODh1GS8SdvLwnMW9ae5zmSj52g1xFOx9ARewdG+GxXgSPmr
 ef4BoVh775pK1ofHv9EEj2bWBbCl79ZSokKk2nKxC1P3oO0Fz7FM1Zki0uhvmK3kG8Lh
 N61Q4l45dyEgFFSMNWJMLJREt3YVdxymk9om8+nLtZNTjFUe6KNt4KChcWwdI+qk7bBY
 PHwT5zmccYX2tV7LBDmd4N8XrRlxo1aARQYh3pL1MP5RePQ6emOrgi+IkrBIWBsSCkGP GA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7pfj8chu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JK3U3x004723;
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16qnpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hWti43975054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB5D22004B;
        Fri, 20 Jan 2023 07:43:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E47F720040;
        Fri, 20 Jan 2023 07:43:31 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:31 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9A457602C2;
        Fri, 20 Jan 2023 18:43:29 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 00/24] pSeries dynamic secure boot secvar interface + platform keyring loading
Date:   Fri, 20 Jan 2023 18:42:42 +1100
Message-Id: <20230120074306.1326298-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BI_ISitNmGvVAhKCVwLPULG_EIz_thMK
X-Proofpoint-GUID: BI_ISitNmGvVAhKCVwLPULG_EIz_thMK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series exposes an interface to userspace for reading and writing
secure variables contained within the PowerVM LPAR Platform KeyStore
(PLPKS) for the purpose of configuring dynamic secure boot, and adds
the glue required to load keys from the PLPKS into the platform keyring.

This series builds on past work by Nayna Jain[0] in exposing PLPKS
variables to userspace.  Rather than being a generic interface for
interacting with the keystore, however, we use the existing powerpc
secvar infrastructure to only expose objects in the keystore used
for dynamic secure boot.  This has the benefit of leveraging an
existing interface and making the implementation relatively minimal.

This series integrates a previous series to fix some bugs in PLPKS
and implement support for signed updates[1], and a cleanup patch from
Michael Ellerman[2].

There are a few relevant details to note about the implementation:

 * New additions to the secvar API: format(), max_size(), config_attrs,
   var_names

 * New optional sysfs directory "config/" for arbitrary ASCII variables

 * Some OPAL-specific code has been relocated from secvar-sysfs.c to
   powernv platform code.  Would appreciate any powernv testing!

 * Variable names are fixed and only those used for secure boot are
   exposed.  This is not a generic PLPKS interface, but also doesn't
   preclude one being added in future.

With this series, both powernv and pseries platforms support dynamic
secure boot through the same interface.

[0]: https://lore.kernel.org/linuxppc-dev/20221106210744.603240-1-nayna@linux.ibm.com/
[1]: https://lore.kernel.org/linuxppc-dev/20221220071626.1426786-1-ajd@linux.ibm.com/
[2]: https://lore.kernel.org/linuxppc-dev/20230112023819.1692452-1-mpe@ellerman.id.au/

v1: https://lore.kernel.org/linuxppc-dev/20221228072943.429266-1-ruscur@russell.cc/
v2: https://lore.kernel.org/linuxppc-dev/20221230042014.154483-1-ruscur@russell.cc/
v3: https://lore.kernel.org/linuxppc-dev/20230118061049.1006141-1-ajd@linux.ibm.com/

=================

Changes in v4:

    Fix the build when CONFIG_PSERIES_PLPKS=n (snowpatch)

    Shuffled fixes to the front the series (npiggin)

    Pass buffer size in secvar_operations->format() (stefanb, npiggin)

    Return an error when set_secvar_ops() fails (npiggin)

    Add some extra null checks (stefanb, gjoyce)

    Add commit message comment elaborating on PAGE_SIZE issues (joel)

    Fix error handling in the kexec code (ruscur)

    Fix hvcall.h MAX_HCALL_OPCODE rebasing issue (npiggin)

Changes in v3:

    Integrate Andrew's PLPKS bugfixes and enhancements series and Michael
    Ellerman's u64 cleanup patch into this series (and update the other
    patches to use u64)

    New patches to load keys from the PLPKS into the kernel's platform
    keyring (ruscur)

    New patches to pass PLPKS password to new kernels when kexecing
    (ruscur)

    Improve handling of format strings (ruscur)

    Clean up secvar error messages (ajd)

    Merge config attributes into secvar_operations (mpe)

    Add a new static variable names API rather than (ab)using get_next()
    (ajd/mpe)

    Warning message when PAGE_SIZE is smaller than the max object size
    (ajd)

    Move plpks.h to the include directory, and move a bunch of constants
    in there with a consistent naming scheme

    Refresh PLPKS config values whenever plpks_get_usedspace() is called
    (ajd)

    Extra validation on PLPKS config values (ruscur)

    Return maxobjlabelsize to userspace as is without subtracting overhead (ruscur)

    Fix error code handling in plpks_confirm_object_flushed() (ruscur)

    Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)

    Make the data buffer in plpks_read_var() caller-allocated to reduce
    number of allocations/copies (mpe)

    Rework the Kconfig options so that PSERIES_PLPKS is a hidden option,
    turned on by enabling PPC_SECURE_BOOT, and the PLPKS secvar code is
    activated by PPC_SECVAR_SYSFS to match powernv (ajd)

    Use machine_arch_initcall() rather than device_initcall() so we don't
    break powernv (mpe)

    Improve ABI documentation (mpe)

    Return -EIO on most read errors (mpe)

    Add "grubdbx" variable (Sudhakar)

    Use utf8s_to_utf16s() rather than our own "UCS-2" conversion code (mpe)

    Fix SB_VERSION data length (ruscur)

    Stop prepending policy data on read (ruscur)

    Don't print errors to the kernel log when reading non-existent
    variables (Sudhakar)

    Miscellaneous code style, checkpatch cleanups

Changes in v2:

    Remove unnecessary config vars from sysfs and document the others,
    thanks to review from Greg.  If we end up needing to expose more, we
    can add them later and update the docs.

    Use sysfs_emit() instead of sprintf() for all sysfs strings

    Change the size of the sysfs binary attributes to include the 8-byte
    flags header, preventing truncation of large writes.

Andrew Donnellan (8):
  powerpc/pseries: Fix handling of PLPKS object flushing timeout
  powerpc/pseries: Fix alignment of PLPKS structures and buffers
  powerpc/secvar: Clean up init error messages
  powerpc/secvar: Allow backend to populate static list of variable
    names
  powerpc/secvar: Warn when PAGE_SIZE is smaller than max object size
  powerpc/secvar: Don't print error on ENOENT when reading variables
  powerpc/pseries: Make caller pass buffer to plpks_read_var()
  powerpc/pseries: Turn PSERIES_PLPKS into a hidden option

Michael Ellerman (1):
  powerpc/secvar: Use u64 in secvar_operations

Nayna Jain (2):
  powerpc/pseries: Expose PLPKS config values, support additional fields
  powerpc/pseries: Implement signed update for PLPKS objects

Russell Currey (13):
  powerpc/secvar: Warn and error if multiple secvar ops are set
  powerpc/secvar: Use sysfs_emit() instead of sprintf()
  powerpc/secvar: Handle format string in the consumer
  powerpc/secvar: Handle max object size in the consumer
  powerpc/secvar: Extend sysfs to include config vars
  powerpc/pseries: Move plpks.h to include directory
  powerpc/pseries: Move PLPKS constants to header file
  powerpc/pseries: Log hcall return codes for PLPKS debug
  powerpc/pseries: Add helpers to get PLPKS password
  powerpc/pseries: Pass PLPKS password on kexec
  powerpc/pseries: Implement secvars for dynamic secure boot
  integrity/powerpc: Improve error handling & reporting when loading
    certs
  integrity/powerpc: Support loading keys from pseries secvar

 Documentation/ABI/testing/sysfs-secvar        |  75 +++-
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/hvcall.h             |   1 +
 arch/powerpc/include/asm/plpks.h              | 187 ++++++++++
 arch/powerpc/include/asm/secvar.h             |  21 +-
 arch/powerpc/kernel/secvar-ops.c              |   8 +-
 arch/powerpc/kernel/secvar-sysfs.c            | 172 +++++----
 arch/powerpc/kexec/file_load_64.c             |  18 +
 arch/powerpc/platforms/powernv/opal-secvar.c  |  60 +++-
 arch/powerpc/platforms/pseries/Kconfig        |  11 +-
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 215 +++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 338 ++++++++++++++----
 arch/powerpc/platforms/pseries/plpks.h        |  71 ----
 .../integrity/platform_certs/load_powerpc.c   |  47 ++-
 15 files changed, 978 insertions(+), 251 deletions(-)
 create mode 100644 arch/powerpc/include/asm/plpks.h
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c
 delete mode 100644 arch/powerpc/platforms/pseries/plpks.h

-- 
2.39.0
