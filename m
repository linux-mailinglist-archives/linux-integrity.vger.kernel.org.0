Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090D8662BDF
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjAIQ5O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjAIQ44 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:56 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01222A
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:56:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NrKfF2hCPz9v7Vm
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S4;
        Mon, 09 Jan 2023 17:56:42 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 2/8] Add config for UML kernel
Date:   Mon,  9 Jan 2023 17:55:46 +0100
Message-Id: <20230109165552.3409716-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43Wr17Kr13Gw4kuFykZrb_yoW3ZFWUpr
        n7JrWxJr4kJr17trW7ArWDGr98tr1DGFWUAr17Xr1UXrykJw4fJr4Ykr1UGr1UXF1UJr48
        JF97Gr13Ar1UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jaUDXUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4dfhAAAsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add config-uml, with test-specific options that are not enabled in the
kernel configuration generated with 'make ARCH=um defconfig'. The new
options will be merged with the merge_config.sh script from the kernel
source code in a Github workflow step.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 config-uml | 235 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 config-uml

diff --git a/config-uml b/config-uml
new file mode 100644
index 000000000000..2d3bb8ba8edb
--- /dev/null
+++ b/config-uml
@@ -0,0 +1,235 @@
+CONFIG_LOCALVERSION="-dont-use"
+CONFIG_WATCH_QUEUE=y
+CONFIG_AUDIT=y
+CONFIG_AUDITSYSCALL=y
+CONFIG_HZ_PERIODIC=y
+CONFIG_LOG_BUF_SHIFT=17
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_SYSTEM_DATA_VERIFICATION=y
+CONFIG_TRACEPOINTS=y
+CONFIG_CON_CHAN="xterm"
+CONFIG_SSL_CHAN="pty"
+CONFIG_MODULE_SIG_FORMAT=y
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_SIG_FORCE=y
+CONFIG_MODULE_SIG_ALL=y
+CONFIG_MODULE_SIG_SHA1=y
+CONFIG_MODULE_SIG_HASH="sha1"
+CONFIG_MODULES_TREE_LOOKUP=y
+CONFIG_BLK_DEBUG_FS=y
+CONFIG_ASN1=y
+CONFIG_UNINLINE_SPIN_UNLOCK=y
+CONFIG_SLUB=y
+CONFIG_COMPACTION=y
+CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
+CONFIG_MIGRATION=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_NULL_TTY=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
+CONFIG_VALIDATE_FS_PARSER=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_EXT4_DEBUG=y
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+CONFIG_REISERFS_FS_SECURITY=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_FS_VERITY=y
+CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_KEYS=y
+CONFIG_ENCRYPTED_KEYS=y
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_PATH=y
+CONFIG_INTEGRITY=y
+CONFIG_INTEGRITY_SIGNATURE=y
+CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
+CONFIG_INTEGRITY_TRUSTED_KEYRING=y
+CONFIG_INTEGRITY_AUDIT=y
+CONFIG_IMA=y
+CONFIG_IMA_MEASURE_PCR_IDX=10
+CONFIG_IMA_NG_TEMPLATE=y
+CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
+CONFIG_IMA_DEFAULT_HASH_SHA256=y
+CONFIG_IMA_DEFAULT_HASH="sha256"
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IMA_READ_POLICY=y
+CONFIG_IMA_APPRAISE=y
+CONFIG_IMA_ARCH_POLICY=y
+CONFIG_IMA_APPRAISE_BUILD_POLICY=y
+CONFIG_IMA_APPRAISE_BOOTPARAM=y
+CONFIG_IMA_APPRAISE_MODSIG=y
+CONFIG_IMA_TRUSTED_KEYRING=y
+CONFIG_IMA_BLACKLIST_KEYRING=y
+CONFIG_IMA_LOAD_X509=y
+CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
+CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
+CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
+CONFIG_EVM=y
+CONFIG_EVM_ATTR_FSUUID=y
+CONFIG_EVM_ADD_XATTRS=y
+CONFIG_EVM_LOAD_X509=y
+CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
+CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_SKCIPHER=y
+CONFIG_CRYPTO_SKCIPHER2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_RNG_DEFAULT=y
+CONFIG_CRYPTO_AKCIPHER2=y
+CONFIG_CRYPTO_AKCIPHER=y
+CONFIG_CRYPTO_KPP2=y
+CONFIG_CRYPTO_ACOMP2=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+CONFIG_CRYPTO_NULL2=y
+CONFIG_CRYPTO_RSA=y
+CONFIG_CRYPTO_ECC=y
+CONFIG_CRYPTO_ECDSA=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_WP512=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRYPTO_ZSTD=y
+CONFIG_CRYPTO_DRBG_MENU=y
+CONFIG_CRYPTO_DRBG_HMAC=y
+CONFIG_CRYPTO_DRBG=y
+CONFIG_CRYPTO_JITTERENTROPY=y
+CONFIG_CRYPTO_HASH_INFO=y
+CONFIG_ASYMMETRIC_KEY_TYPE=y
+CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
+CONFIG_X509_CERTIFICATE_PARSER=y
+CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
+CONFIG_PKCS7_MESSAGE_PARSER=y
+CONFIG_PKCS7_TEST_KEY=y
+CONFIG_SIGNED_PE_FILE_VERIFICATION=y
+CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
+CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_TRUSTED_KEYS=""
+CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
+CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
+CONFIG_SECONDARY_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_BLACKLIST_KEYRING=y
+CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
+CONFIG_SYSTEM_REVOCATION_LIST=y
+CONFIG_SYSTEM_REVOCATION_KEYS=""
+CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
+CONFIG_BINARY_PRINTF=y
+CONFIG_CRYPTO_LIB_AES=y
+CONFIG_CRYPTO_LIB_SHA256=y
+CONFIG_CRC_CCITT=y
+CONFIG_XXHASH=y
+CONFIG_AUDIT_GENERIC=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_ZSTD_COMMON=y
+CONFIG_ZSTD_COMPRESS=y
+CONFIG_ZSTD_DECOMPRESS=y
+CONFIG_ASSOCIATIVE_ARRAY=y
+CONFIG_SGL_ALLOC=y
+CONFIG_GLOB=y
+CONFIG_CLZ_TAB=y
+CONFIG_MPILIB=y
+CONFIG_SIGNATURE=y
+CONFIG_OID_REGISTRY=y
+CONFIG_STACKDEPOT=y
+CONFIG_STACKDEPOT_ALWAYS_INIT=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PRINTK_CALLER=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DYNAMIC_DEBUG_CORE=y
+CONFIG_DEBUG_INFO_DWARF5=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_FRAME_WARN=2048
+CONFIG_READABLE_ASM=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_FS_ALLOW_ALL=y
+CONFIG_UBSAN=y
+CONFIG_CC_HAS_UBSAN_BOUNDS=y
+CONFIG_UBSAN_BOUNDS=y
+CONFIG_UBSAN_ONLY_BOUNDS=y
+CONFIG_UBSAN_SHIFT=y
+CONFIG_UBSAN_DIV_ZERO=y
+CONFIG_UBSAN_BOOL=y
+CONFIG_UBSAN_ENUM=y
+CONFIG_UBSAN_ALIGNMENT=y
+CONFIG_PAGE_EXTENSION=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_SLUB_DEBUG_ON=y
+CONFIG_PAGE_OWNER=y
+CONFIG_PAGE_POISONING=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_FREE=y
+CONFIG_DEBUG_OBJECTS_TIMERS=y
+CONFIG_DEBUG_OBJECTS_WORK=y
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
+CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
+CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
+CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
+CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PANIC_ON_OOPS_VALUE=1
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_DEBUG_TIMEKEEPING=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PROVE_RAW_LOCK_NESTING=y
+CONFIG_LOCK_STAT=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
+CONFIG_DEBUG_RWSEMS=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_LOCKDEP=y
+CONFIG_LOCKDEP_BITS=15
+CONFIG_LOCKDEP_CHAINS_BITS=16
+CONFIG_LOCKDEP_STACK_TRACE_BITS=19
+CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
+CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
+CONFIG_WW_MUTEX_SELFTEST=y
+CONFIG_CSD_LOCK_WAIT_DEBUG=y
+CONFIG_TRACE_IRQFLAGS=y
+CONFIG_DEBUG_IRQFLAGS=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_PLIST=y
+CONFIG_DEBUG_SG=y
+CONFIG_DEBUG_NOTIFIERS=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_PROVE_RCU=y
+CONFIG_RCU_TRACE=y
+CONFIG_NOP_TRACER=y
+CONFIG_TRACE_CLOCK=y
+CONFIG_RING_BUFFER=y
+CONFIG_EVENT_TRACING=y
+CONFIG_CONTEXT_SWITCH_TRACER=y
+CONFIG_PREEMPTIRQ_TRACEPOINTS=y
+CONFIG_TRACING=y
-- 
2.25.1

