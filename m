Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584E66760D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjALO2R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 09:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALO1y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 09:27:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578457915
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 06:18:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEBISd019321;
        Thu, 12 Jan 2023 14:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ONWTh7kFpEvFY/uYyabMjbkGF4XlW+S7OXoVy2+a0iA=;
 b=LoTB+5pEzt76FgHvdOP/OywswM3d3e/clC5jqwYpgbqbR1pBt0h957joM9wUYHzU0fRO
 vW7WCLV10rbEHbF3CInhnu61PVYC/nOQh44B/YZtsK7ks6ZeKNOGPOQAfO17fKptrMVi
 mEWukRVxRSYnnrsgXkV6Q6X/GfbvJ/GpCeKv+01Q/+GkExJ3arxoUcOhS5iMLhkXb71I
 jUHf4RFm9tygbJ9U3Pearno+bLpLbG5zDLGSpyDyapugd12BEEadTZhWWL4MoYN6BFw5
 Yzo/sHK+qEYGGXpJoJlDi7CzrdEVMLO6TR7uMbwkkkrXRCGC1tco94FSFLe84r0w1Ear dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2hkbuupe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:18:23 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CDIFtr011827;
        Thu, 12 Jan 2023 14:18:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2hkbuuny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:18:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CBvafW019832;
        Thu, 12 Jan 2023 14:18:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n1k844505-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:18:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CEIK1d24314238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 14:18:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A4955803F;
        Thu, 12 Jan 2023 14:18:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7FD15804E;
        Thu, 12 Jan 2023 14:18:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 14:18:19 +0000 (GMT)
Message-ID: <84d1ace4-a14a-c6fa-718d-e65925546543@linux.ibm.com>
Date:   Thu, 12 Jan 2023 09:18:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 2/9] Add config for UML kernel
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mHz2fHknsy2mrsZnd3AlhiaGtZPSNDqT
X-Proofpoint-GUID: 9WpaBThvrwsINQupWEhXYgeRxDuVzkeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add config-uml, with test-specific options that are not enabled in the
> kernel configuration generated with 'make ARCH=um olddefconfig'. The new
> options will be merged with the merge_config.sh script from the kernel
> source code in a Github workflow step.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   config-uml | 235 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 235 insertions(+)
>   create mode 100644 config-uml
> 
> diff --git a/config-uml b/config-uml
> new file mode 100644
> index 000000000000..2d3bb8ba8edb
> --- /dev/null
> +++ b/config-uml
> @@ -0,0 +1,235 @@
> +CONFIG_LOCALVERSION="-dont-use"
> +CONFIG_WATCH_QUEUE=y
> +CONFIG_AUDIT=y
> +CONFIG_AUDITSYSCALL=y
> +CONFIG_HZ_PERIODIC=y
> +CONFIG_LOG_BUF_SHIFT=17
> +CONFIG_USER_NS=y
> +CONFIG_PID_NS=y
> +CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_SYSTEM_DATA_VERIFICATION=y
> +CONFIG_TRACEPOINTS=y
> +CONFIG_CON_CHAN="xterm"
> +CONFIG_SSL_CHAN="pty"
> +CONFIG_MODULE_SIG_FORMAT=y
> +CONFIG_MODULE_SIG=y
> +CONFIG_MODULE_SIG_FORCE=y
> +CONFIG_MODULE_SIG_ALL=y
> +CONFIG_MODULE_SIG_SHA1=y
> +CONFIG_MODULE_SIG_HASH="sha1"
> +CONFIG_MODULES_TREE_LOOKUP=y
> +CONFIG_BLK_DEBUG_FS=y
> +CONFIG_ASN1=y
> +CONFIG_UNINLINE_SPIN_UNLOCK=y
> +CONFIG_SLUB=y
> +CONFIG_COMPACTION=y
> +CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
> +CONFIG_MIGRATION=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_LEGACY_PTY_COUNT=256
> +CONFIG_NULL_TTY=y
> +CONFIG_SERIAL_DEV_BUS=y
> +CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> +CONFIG_VALIDATE_FS_PARSER=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_EXT4_DEBUG=y
> +CONFIG_REISERFS_FS_XATTR=y
> +CONFIG_REISERFS_FS_POSIX_ACL=y
> +CONFIG_REISERFS_FS_SECURITY=y
> +CONFIG_FS_POSIX_ACL=y
> +CONFIG_FS_VERITY=y
> +CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_TMPFS_XATTR=y
> +CONFIG_CONFIGFS_FS=y
> +CONFIG_KEYS=y
> +CONFIG_ENCRYPTED_KEYS=y
> +CONFIG_SECURITY=y
> +CONFIG_SECURITYFS=y
> +CONFIG_SECURITY_NETWORK=y
> +CONFIG_SECURITY_PATH=y
> +CONFIG_INTEGRITY=y
> +CONFIG_INTEGRITY_SIGNATURE=y
> +CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> +CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> +CONFIG_INTEGRITY_AUDIT=y
> +CONFIG_IMA=y
> +CONFIG_IMA_MEASURE_PCR_IDX=10
> +CONFIG_IMA_NG_TEMPLATE=y
> +CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> +CONFIG_IMA_DEFAULT_HASH_SHA256=y
> +CONFIG_IMA_DEFAULT_HASH="sha256"
> +CONFIG_IMA_WRITE_POLICY=y
> +CONFIG_IMA_READ_POLICY=y
> +CONFIG_IMA_APPRAISE=y
> +CONFIG_IMA_ARCH_POLICY=y
> +CONFIG_IMA_APPRAISE_BUILD_POLICY=y
> +CONFIG_IMA_APPRAISE_BOOTPARAM=y
> +CONFIG_IMA_APPRAISE_MODSIG=y
> +CONFIG_IMA_TRUSTED_KEYRING=y
> +CONFIG_IMA_BLACKLIST_KEYRING=y
> +CONFIG_IMA_LOAD_X509=y
> +CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
> +CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> +CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> +CONFIG_EVM=y
> +CONFIG_EVM_ATTR_FSUUID=y
> +CONFIG_EVM_ADD_XATTRS=y
> +CONFIG_EVM_LOAD_X509=y
> +CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
> +CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> +CONFIG_CRYPTO_AEAD2=y
> +CONFIG_CRYPTO_SKCIPHER=y
> +CONFIG_CRYPTO_SKCIPHER2=y
> +CONFIG_CRYPTO_RNG=y
> +CONFIG_CRYPTO_RNG2=y
> +CONFIG_CRYPTO_RNG_DEFAULT=y
> +CONFIG_CRYPTO_AKCIPHER2=y
> +CONFIG_CRYPTO_AKCIPHER=y
> +CONFIG_CRYPTO_KPP2=y
> +CONFIG_CRYPTO_ACOMP2=y
> +CONFIG_CRYPTO_MANAGER=y
> +CONFIG_CRYPTO_MANAGER2=y
> +CONFIG_CRYPTO_NULL2=y
> +CONFIG_CRYPTO_RSA=y
> +CONFIG_CRYPTO_ECC=y
> +CONFIG_CRYPTO_ECDSA=y
> +CONFIG_CRYPTO_AES=y
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_MD5=y
> +CONFIG_CRYPTO_SHA1=y
> +CONFIG_CRYPTO_SHA256=y
> +CONFIG_CRYPTO_SHA512=y
> +CONFIG_CRYPTO_WP512=y
> +CONFIG_CRYPTO_LZO=y
> +CONFIG_CRYPTO_ZSTD=y
> +CONFIG_CRYPTO_DRBG_MENU=y
> +CONFIG_CRYPTO_DRBG_HMAC=y
> +CONFIG_CRYPTO_DRBG=y
> +CONFIG_CRYPTO_JITTERENTROPY=y
> +CONFIG_CRYPTO_HASH_INFO=y
> +CONFIG_ASYMMETRIC_KEY_TYPE=y
> +CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> +CONFIG_X509_CERTIFICATE_PARSER=y
> +CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> +CONFIG_PKCS7_MESSAGE_PARSER=y
> +CONFIG_PKCS7_TEST_KEY=y
> +CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> +CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> +CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
> +CONFIG_SYSTEM_TRUSTED_KEYRING=y
> +CONFIG_SYSTEM_TRUSTED_KEYS=""
> +CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> +CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> +CONFIG_SECONDARY_TRUSTED_KEYRING=y
> +CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> +CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> +CONFIG_SYSTEM_REVOCATION_LIST=y
> +CONFIG_SYSTEM_REVOCATION_KEYS=""
> +CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
> +CONFIG_BINARY_PRINTF=y
> +CONFIG_CRYPTO_LIB_AES=y
> +CONFIG_CRYPTO_LIB_SHA256=y
> +CONFIG_CRC_CCITT=y
> +CONFIG_XXHASH=y
> +CONFIG_AUDIT_GENERIC=y
> +CONFIG_LZO_COMPRESS=y
> +CONFIG_LZO_DECOMPRESS=y
> +CONFIG_ZSTD_COMMON=y
> +CONFIG_ZSTD_COMPRESS=y
> +CONFIG_ZSTD_DECOMPRESS=y
> +CONFIG_ASSOCIATIVE_ARRAY=y
> +CONFIG_SGL_ALLOC=y
> +CONFIG_GLOB=y
> +CONFIG_CLZ_TAB=y
> +CONFIG_MPILIB=y
> +CONFIG_SIGNATURE=y
> +CONFIG_OID_REGISTRY=y
> +CONFIG_STACKDEPOT=y
> +CONFIG_STACKDEPOT_ALWAYS_INIT=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_PRINTK_CALLER=y
> +CONFIG_DYNAMIC_DEBUG=y
> +CONFIG_DYNAMIC_DEBUG_CORE=y
> +CONFIG_DEBUG_INFO_DWARF5=y
> +CONFIG_GDB_SCRIPTS=y
> +CONFIG_FRAME_WARN=2048
> +CONFIG_READABLE_ASM=y
> +CONFIG_DEBUG_SECTION_MISMATCH=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_DEBUG_FS_ALLOW_ALL=y
> +CONFIG_UBSAN=y
> +CONFIG_CC_HAS_UBSAN_BOUNDS=y
> +CONFIG_UBSAN_BOUNDS=y
> +CONFIG_UBSAN_ONLY_BOUNDS=y
> +CONFIG_UBSAN_SHIFT=y
> +CONFIG_UBSAN_DIV_ZERO=y
> +CONFIG_UBSAN_BOOL=y
> +CONFIG_UBSAN_ENUM=y
> +CONFIG_UBSAN_ALIGNMENT=y
> +CONFIG_PAGE_EXTENSION=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> +CONFIG_SLUB_DEBUG=y
> +CONFIG_SLUB_DEBUG_ON=y
> +CONFIG_PAGE_OWNER=y
> +CONFIG_PAGE_POISONING=y
> +CONFIG_DEBUG_OBJECTS=y
> +CONFIG_DEBUG_OBJECTS_FREE=y
> +CONFIG_DEBUG_OBJECTS_TIMERS=y
> +CONFIG_DEBUG_OBJECTS_WORK=y
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> +CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> +CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> +CONFIG_DEBUG_KMEMLEAK=y
> +CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> +CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> +CONFIG_DEBUG_STACK_USAGE=y
> +CONFIG_SCHED_STACK_END_CHECK=y
> +CONFIG_DEBUG_SHIRQ=y
> +CONFIG_PANIC_ON_OOPS=y
> +CONFIG_PANIC_ON_OOPS_VALUE=1
> +CONFIG_LOCKUP_DETECTOR=y
> +CONFIG_SOFTLOCKUP_DETECTOR=y
> +CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> +CONFIG_DETECT_HUNG_TASK=y
> +CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> +CONFIG_WQ_WATCHDOG=y
> +CONFIG_DEBUG_TIMEKEEPING=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_PROVE_RAW_LOCK_NESTING=y
> +CONFIG_LOCK_STAT=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> +CONFIG_DEBUG_RWSEMS=y
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_LOCKDEP=y
> +CONFIG_LOCKDEP_BITS=15
> +CONFIG_LOCKDEP_CHAINS_BITS=16
> +CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> +CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> +CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> +CONFIG_WW_MUTEX_SELFTEST=y
> +CONFIG_CSD_LOCK_WAIT_DEBUG=y
> +CONFIG_TRACE_IRQFLAGS=y
> +CONFIG_DEBUG_IRQFLAGS=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_PLIST=y
> +CONFIG_DEBUG_SG=y
> +CONFIG_DEBUG_NOTIFIERS=y
> +CONFIG_BUG_ON_DATA_CORRUPTION=y
> +CONFIG_PROVE_RCU=y
> +CONFIG_RCU_TRACE=y
> +CONFIG_NOP_TRACER=y
> +CONFIG_TRACE_CLOCK=y
> +CONFIG_RING_BUFFER=y
> +CONFIG_EVENT_TRACING=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
> +CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> +CONFIG_TRACING=y
