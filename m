Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9776366DC
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 18:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiKWRUe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 12:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiKWRUd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 12:20:33 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2315C77B
        for <linux-integrity@vger.kernel.org>; Wed, 23 Nov 2022 09:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669224027; bh=H6so23HiOeBQ/mSbygcFjFWDwe7VHP69UgZi++e/650=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Zcq/A2bJNc6oL4rGmHPzSC2El4SUAxQPhoa3istSXjJ8zBQ3Phc7QvZwJmbolH9YoSrZRB2U6gGLdu00MgR3QaWn3bKLWfID06rV9wc9IcUxoM2HRXy3XgJG5F1f4vGV4eyVIx/Mo+cdqEOFobdtVAV1VJeRX9BgOzzOSQBZ22WJXx5eWS6oetIIFNdwob5l1tYb+7iKakqU9DK3kk/tkbA20EgxU71Yn5Q0HMPUd+LagFcsw/MoYvoIrV4VuYLJJfNydvO7uZjePQQ1laDUPzU6TVml/4EcaPOzYvCpyU03LDHikbKVxCkG9bb/Ykt+bIQnsA/gEp4e3Cdwj4LtTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669224027; bh=iXiUurtvZKFGEI4+0BPWUrIphS0TlaU7ZbeWKK6Nz5G=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=M+NwI3IhK9M10HxxWqgUWiCt97s2fTvw2VOevDYFpsjtnqvAVusEIUTahnwKsyhmklbIl7qMkTWRv0BGdjtoEsIFCvswIsOTNzCEAc9fV+K10QS5pwwxamNBklcTYPGwExmZWPnVYGvVlsmoMGJ5o4mPjxNwz/L8agjxUVGTippUxdooPAH1ymgslg23j/sx2PQz2+ZScPnQEngWIeUZZsXW9UaeT0phWd5McT99+WBtsxo54yUpOULywC9iwiiu/W933ZVxfgrG8FKPoYQKDf2wZ8Ism/h646Blr7iIMef742MnTTA3kR5D0SSuVkX5EzhmF5GNB3NwC7PZZEZaYQ==
X-YMail-OSG: ivwxf9AVM1m9jr2YMsXO6brqTTr5QtXd2_qb9YZJ9JXG5XcpUwZ6jbck3MXOOCb
 Ssr066pNMjD1DFq.KyjrPmka_HkCBpBdEIL_VtVs7fB6AMymO2BGEaS5JW2O9PuCvovjmsFX3OHT
 C0RdgzU71J.vlj4OSLsMVa814FPFPcijaIQf52_xB_nxe8G71gaicxvNx77DKZgvFfJxZD8pm.EF
 O3hDXPS.Yc8iRbUST3cA30RXkWk6BlRRLaap941T0YznCMt1EkfAW1IuV_mAWxMawkDl4znsA4_O
 aI_YkeSogUxwe2.o1Q4hAKjYzbhVGNU4I8RgoBCSj6QsYQA88ECYdrhG4NTOHqN6jb1L76S5uhln
 DyjAtLpOmH7S1lQyC00IcvvjFvfhI9nfAsPocoUyIa53ww.uzJ5t_5z1GLQjFYpEPpCd44EB24JT
 vU3gZ7AjZm7i6c9rh4r0zlrsEd4rQKp_Jsms70UpMmUuYEi57R..JNzwCt8LIe2IZc1.fousdsCq
 gsgB0LMHubEZZgshpKaO5bpqslX2sERHA.6wQDVQnB05k4EyIpwBXLDucESp5PUIkB5mgj8_tGha
 .EOZRpSVbw8DWsj8UtY3umN8OvxRdelgEnavyDw4ns48tMjpE1W8Ycskw4UjqLHc3kn.yIymQqQ6
 Gpw3Yio6bH1.sC57K2FCUwWjXq0yfir.Q.X4sS.glIsyJujb5j7hLBmNMMoLMIKq4obJBQcuhnFb
 u4aN5X.ArbuzYh5aIXNnYg0ysWe6BiKv3TcnVDDaa64ED9yf4AIWTmGcRX.meCh5haIgZpjDMn7h
 GVGUMCt2vI8bfdPaFFGeiaifAe8HxlThB3V1VUrsGfKvoDE_vGYM9noxkvFsmxpk4tMjLqp_9cAE
 3En4bimuYoe1vWD4d75oHv8MdNdxSsMgaSM4OTeoqq8K8CS_Wobg9ySw6ectN99tcf4yOX54Rare
 9Z0.ssuot7WRtKt3JNbm6mYCSoj8cWWknetQsRFktaam.mvjwMjnrJfck5MSr1H4UJLzFWdxZ4ca
 xugud54RdNHn3H2TFmhdqyWHhAOAiIOOI_QqbD9yLItu56SwcjaAfoIM41kYzL959Z2pEhq_DYlZ
 bbWCw0uQ3lnlgphqLqmuaEqlPzXYxmlCWA4gSe7RN9tNQiMK6cDnp2PJ3.WTeUQsUF1do._ipG.9
 7qmqPfDXFnjco_NnDwd9xRurhjRyVqmxb5NNupWcHDYOnoSC36ml2.NQIeZiAdVGypNmg34RCkLb
 vciqVz8WpNhfiApEVBC5uo6XV1f0y8kfGCWSQL6i8Qf2U6l9Ir2BlYmlCFhLkSfknbcdlilZIsBw
 fEPJJjVWg1IowvI1Qk9Rf1RWOXV3YEuOvFCo4DIhUFr9P487.w63Sk3n3LaipvZl0qDGg6QDB_CO
 _a8HKjiBp4cEijPuvWXoRUWXGJMoJ5BFzX9pJ_5_20g95SmV1yAxb6DsofisG.kkiHSiP1ASoDI7
 Ctd7Tt0JgQEF0k1YVTc8dGA5scVpD1BQ05GPA4kR0aKNQXo4r0Dg1_UhEkWaGstlzUB7UduVUPEQ
 hapYaqiaRGFdj8YY2XGM6q.p45aCqZlEEHC4JwJuEFfh0Dt7_MPu91_5XvuE.dwtiuwrrc9QTGES
 bHMDXCzHvuACz.m._uuf_9raL5.omSzZ7oWT0XXKJucxBkYOUvVIYoQfyNSA9XMhY0tQkzmyswGI
 dC9qV6kisRoqU4Nuk7UT3kgMpMJ6TvDXvt2NzdurJc87_u9OgkTOAKxplSxAQFaTpboS5qYwpuzX
 Edur9CelCt81Qi8OrWnn4zl6eqNGETWP1ZImea0ZYclJTXDa_lQShdwmqa8jNhU96FKPEKf7dXVV
 AcqIRR9wAM6RyMEKh8ScUbMzRlcFRJZ7ukFBo3FxooPK2NZGqIht95OxgaDiM.uY903b79oggyqn
 e5_mdkKlDobW3A6jupp3O_epeBAsLsJKui81cofXYcV_LYhntnadmRT8dBMShAHdxBt8EKX6EI6q
 Sk2w5CTgrGnpK8p05NOWhQ6HMh5WANr8SlzoNBbR_aqSSbmaNoTIKPVZHoBuon.0wxhXJuAKDI7Y
 ks2PSYjpl4w8boPzaMloqS4KB5ySownUXy46AOzD4..4ZlN5oKwLkYTg2O_NOBnn7snGQRzLHdgu
 ZiZbXN3RBHl0fw6rBm9A4yG3JdyzlQVSVFgf7bnjIOfKbdrsiGh1GM4hichfZHpm5XEjpYhWdyG2
 aExzr1.Rxxi_x85HpHKI7IGcdt1wYjp94komZuBAQ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 17:20:27 +0000
Received: by hermes--production-gq1-579bc4bddd-hwj6j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 44c42fa7d46c3b0b822e2ac20a19b36e;
          Wed, 23 Nov 2022 17:20:25 +0000 (UTC)
Message-ID: <0f77f1cd-1563-b879-ea89-0fcfcb1ac068@schaufler-ca.com>
Date:   Wed, 23 Nov 2022 09:20:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 0/6] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/23/2022 7:47 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

For the series:
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

I had one minor comment on 4/6. Thank you.

>
> One of the major goals of LSM stacking is to run multiple LSMs side by side
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them.
>
> The first problem that this patch set addresses is to make the
> inode_init_security hook definition suitable to use with EVM which, unlike
> other LSMs, needs to have visibility of all xattrs and not only the one
> that the LSM infrastructure passes to the LSM to be set.
>
> The solution is to replace in the inode_init_security definition the
> name/value/len parameters with the beginning of the array containing all
> xattrs set by LSMs. Due to security_old_inode_init_security() API
> limitation of setting only one xattr, it has been dropped and the remaining
> users, ocfs2 and reiserfs, switch to security_inode_init_security().
> However, due to the complexity of the changes required to fully exploit the
> ability of security_inode_init_security() to set multiple xattrs, those
> users can still set only one xattr (the first set in the xattr array) where
> previously they called security_old_inode_init_security().
>
> Furthermore, while EVM is invoked unlike before, its xattr will not be set
> as it would not be the first set in the xattr array, or if it is the first,
> there would not be protected xattrs to calculate the HMAC on.
>
> The second problem this patch set addresses is the limitation of the
> call_int_hook() of stopping the loop when the return value from a hook
> implementation is not zero. Unfortunately, for the inode_init_security hook
> it is a legitimate case to return -EOPNOTSUPP, but this would not
> necessarily mean that there is an error to report to the LSM infrastructure
> but just that an LSM does not will to set an xattr. Other LSMs should be
> still consulted as well.
>
> The solution for this specific case is to replace the call_int_hook() with
> the loop itself, so that -EOPNOTSUPP can be ignored.
>
> Next, this patch set removes the limitation of creating only two xattrs,
> one by an active LSM and another by EVM. This patch set extends the
> reservation mechanism of the LSM infrastructure, to allow each LSM to
> request one or multiple xattrs. While this could potentially lead to
> reaching the filesystem limits of number/size of the xattrs, it seems not
> an issue that need to be solved by the LSM infrastructure but by the
> filesystems themselves. Currently, if the limit is reached, the only
> workaround would be to use fewer LSMs.
>
> The reservation mechanism concept makes it very easy for LSMs to position
> themselves correctly in the xattr array, as the LSM infrastructure at
> initialization time changes the number of xattrs requested by each LSM with
> an offset. LSMs can just take that offset as the starting index in the
> xattr array and fill the next slots depending on how many xattrs they
> requested.
>
> However, while this concept is intuitive, it needs extra care. While for
> security blobs (the main reason of the reservation mechanism) it is not
> relevant for an LSM if other LSMs filled their portion, it matters for
> xattrs, as both EVM and initxattrs() callbacks scan the entire array until
> a terminator (xattr with NULL name). If an LSM did not provide an xattr,
> which could happen if it is loaded but not initialized, consumers of the
> xattr array would stop prematurely.
>
> This patch set avoids this problem by compacting the xattr array each time
> after an LSM executed its implementation of the inode_init_security hook.
> It needs to be done after each LSM, and not after all, since there might be
> LSMs scanning that xattr array too. Compacting the array after all LSMs
> would be too late.
>
> Finally, this patch set modifies the evm_inode_init_security() definition
> to be compatible with the inode_init_security hook definition and adds
> support for scanning the whole xattr array and for calculating the HMAC
> on all xattrs provided by LSMs.
>
> This patch set has been tested by introducing several instances of a
> TestLSM (some providing an xattr, some not, one with a wrong implementation
> to see how the LSM infrastructure handles it, one providing multiple xattrs
> and another providing an xattr but in a disabled state). The patch is not
> included in this set but it is available here:
>
> https://github.com/robertosassu/linux/commit/e13a03236df0c399dccb73df5fe4cfceb4bb1d89
>
> The test, added to ima-evm-utils, is available here:
>
> https://github.com/robertosassu/ima-evm-utils/blob/evm-multiple-lsms-v5-devel-v3/tests/evm_multiple_lsms.test
>
> The test takes a UML kernel built by Github Actions and launches it several
> times, each time with a different combination of LSMs and filesystems (ext4,
> reiserfs, ocfs2). After boot, it first checks that there is an xattr for each
> LSM providing it (for reiserfs and ocfs2 just the first LSM), and then (for
> ext4) calculates the HMAC in user space and compares it with the HMAC
> calculated by EVM in kernel space.
>
> A test report can be obtained here:
>
> https://github.com/robertosassu/ima-evm-utils/actions/runs/3525619568/jobs/5912560168
>
> The patch set has been tested with both the SElinux and Smack test suites.
> Below, there is the summary of the test results:
>
> SELinux Test Suite result (without patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.
>
> SELinux Test Suite result (with patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.
>
> Smack Test Suite result (without patches):
> 95 Passed, 0 Failed, 100% Success rate
>
> Smack Test Suite result (with patches):
> 95 Passed, 0 Failed, 100% Success rate
>
> Changelog
>
> v5:
> - Modify the cover letter to explain that the goal of this patch set is
>   supporting multiple per LSM xattrs in EVM, and not moving IMA and EVM to
>   the LSM infrastructure
> - Remove references in the patches description about moving IMA and EVM
>   to the LSM infrastructure
> - Explain that the additional EVM invocation due to the switch to
>   security_inode_init_security() will not cause the EVM xattr to be added
>
> v4:
> - Remove patch to call reiserfs_security_free(), already queued
> - Switch ocfs2 and reiserfs to security_inode_init_security() (suggested by
>   Mimi)
> - Remove security_old_inode_init_security() (suggested by Paul)
> - Rename security_check_compact_xattrs() to
>   security_check_compact_filled_xattrs() and add function description
>   (suggested by Mimi)
> - Rename checked_xattrs parameter of security_check_compact_filled_xattrs()
>   to num_filled_xattrs (suggested by Mimi)
> - Rename cur_xattrs variable in security_inode_init_security() to
>   num_filled_xattrs (suggested by Mimi)
>
> v3:
> - Don't free the xattr name in reiserfs_security_free()
> - Don't include fs_data parameter in inode_init_security hook
> - Don't change evm_inode_init_security(), as it will be removed if EVM is
>   stacked
> - Fix inode_init_security hook documentation
> - Drop lsm_find_xattr_slot(), use simple xattr reservation mechanism and
>   introduce security_check_compact_xattrs() to compact the xattr array
> - Don't allocate xattr array if LSMs didn't reserve any xattr
> - Return zero if initxattrs() is not provided to
>   security_inode_init_security(), -EOPNOTSUPP if value is not provided to
>   security_old_inode_init_security()
> - Request LSMs to fill xattrs if only value (not the triple) is provided to
>   security_old_inode_init_security(), to avoid unnecessary memory
>   allocation
>
> v2:
> - rewrite selinux_old_inode_init_security() to use
>   security_inode_init_security()
> - add lbs_xattr field to lsm_blob_sizes structure, to give the ability to
>   LSMs to reserve slots in the xattr array (suggested by Casey)
> - add new parameter base_slot to inode_init_security hook definition
>
> v1:
> - add calls to reiserfs_security_free() and initialize sec->value to NULL
>   (suggested by Tetsuo and Mimi)
> - change definition of inode_init_security hook, replace the name, value
>   and len triple with the xattr array (suggested by Casey)
> - introduce lsm_find_xattr_slot() helper for LSMs to find an unused slot in
>   the passed xattr array
>
> Roberto Sassu (6):
>   reiserfs: Switch to security_inode_init_security()
>   ocfs2: Switch to security_inode_init_security()
>   security: Remove security_old_inode_init_security()
>   security: Allow all LSMs to provide xattrs for inode_init_security
>     hook
>   evm: Align evm_inode_init_security() definition with LSM
>     infrastructure
>   evm: Support multiple LSMs providing an xattr
>
>  fs/ocfs2/namei.c                    |  18 ++---
>  fs/ocfs2/xattr.c                    |  30 +++++++-
>  fs/reiserfs/xattr_security.c        |  23 ++++--
>  include/linux/evm.h                 |  12 +--
>  include/linux/lsm_hook_defs.h       |   3 +-
>  include/linux/lsm_hooks.h           |  17 ++--
>  include/linux/security.h            |  12 ---
>  security/integrity/evm/evm.h        |   2 +
>  security/integrity/evm/evm_crypto.c |   9 ++-
>  security/integrity/evm/evm_main.c   |  28 +++++--
>  security/security.c                 | 115 +++++++++++++++++++++-------
>  security/selinux/hooks.c            |  19 +++--
>  security/smack/smack_lsm.c          |  26 ++++---
>  13 files changed, 213 insertions(+), 101 deletions(-)
>
