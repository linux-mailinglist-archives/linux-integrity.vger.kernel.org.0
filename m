Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C76815FB
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 17:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjA3QH4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjA3QHw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 11:07:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B46741B5E
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 08:07:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P5CYG273xz9xFrQ
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 23:59:30 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDncAw+69dj5iLdAA--.56167S2;
        Mon, 30 Jan 2023 17:07:32 +0100 (CET)
Message-ID: <7779927be4c5506172c5a64e3cea37ad9c285356.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 17:07:18 +0100
In-Reply-To: <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
         <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDncAw+69dj5iLdAA--.56167S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4DCw1DCF4kKr1kCr4kWFg_yoW7uF18pa
        1kZasagw1DKFyjq3ykA3Wvvr40yr4UKFyUWrykJF18J3y5ZayUK343JayDuFykG3Zavan7
        AF18K3WkWF17GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4hIdgAAsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 15:02 +0100, Roberto Sassu wrote:
> On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> > [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> > Petr.]
> > 
> > On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > > How do you tell the user that the patches need to be applied for the test to
> > > > succeed and not worry about it when the patches are not applied?
> > > 
> > > Uhm, I agree. I should at least write a comment as for EVM portable
> > > signatures, and maybe display a message in the test logs.
> > 
> > This is a generic problem that needs to be addressed.  FYI, LTP
> > addressed it by introducing "struct test_tag" in commit ca2c76990
> > ("lib: Add support for test tags").
> 
> One idea could be to list all the patches the group of tests is going
> to check, and add an argument to expect_pass and expect_fail to specify
> the indexes of patches required for the test. We print the required
> patches in an error message.

Ok, here is an example for this patch set. I added the following
changes to the mmap_check.test script:

PATCHES=(
'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
'ima: Introduce MMAP_CHECK_REQPROT hook'
)

[...]

expect_fail check_mmap "MMAP_CHECK" ""
expect_pass check_mmap "MMAP_CHECK" "exec"
expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"

expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" ""
expect_pass_if '1' check_mmap "MMAP_CHECK_REQPROT" "exec"
expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" "read_implies_exec"

expect_pass check_deny "MMAP_CHECK" "mprotect"
expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "mprotect"

expect_pass check_deny "MMAP_CHECK" "exec_on_writable"
expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "exec_on_writable"

I didn't add the _if suffix for the tests that are expected to
pass/fail without adding new patches.


I introduced expect_pass_if() and expect_fail_if() that call
respectively expect_pass() and expect_fail(), and additionally print an
error message with the patches that might be required.


The test results (without the two kernel patches applied) are:

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "")
Result (expect not found): not found

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "exec")
Result (expect found): found

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "read_implies_exec")
Result (expect found): not found
Possibly missing patches:
 - ima: Align ima_file_mmap() parameters with mmap_file LSM hook

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "")
/home/roberto/repos/ima-evm-utils/tests/mmap_check.test: line 65: echo: write error: Invalid argument
Failed to set IMA policy
Possibly missing patches:
 - ima: Introduce MMAP_CHECK_REQPROT hook

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "exec")
/home/roberto/repos/ima-evm-utils/tests/mmap_check.test: line 65: echo: write error: Invalid argument
Failed to set IMA policy
Possibly missing patches:
 - ima: Introduce MMAP_CHECK_REQPROT hook

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "read_implies_exec")
/home/roberto/repos/ima-evm-utils/tests/mmap_check.test: line 65: echo: write error: Invalid argument
Failed to set IMA policy
Possibly missing patches:
 - ima: Introduce MMAP_CHECK_REQPROT hook

Test: check_deny (hook="MMAP_CHECK", test_mmap arg: "mprotect")
Result (expect denied): denied

Test: check_deny (hook="MMAP_CHECK_REQPROT", test_mmap arg: "mprotect")
/home/roberto/repos/ima-evm-utils/tests/mmap_check.test: line 65: echo: write error: Invalid argument
Failed to set IMA policy
Possibly missing patches:
 - ima: Introduce MMAP_CHECK_REQPROT hook

Test: check_deny (hook="MMAP_CHECK", test_mmap arg: "exec_on_writable")
Result (expect denied): denied

Test: check_deny (hook="MMAP_CHECK_REQPROT", test_mmap arg: "exec_on_writable")
/home/roberto/repos/ima-evm-utils/tests/mmap_check.test: line 65: echo: write error: Invalid argument
Failed to set IMA policy
Possibly missing patches:
 - ima: Introduce MMAP_CHECK_REQPROT hook
=================================
 Run with FAILEARLY=1 /home/roberto/repos/ima-evm-utils/tests/mmap_check.test _cleanup_env cleanup
 To stop after first failure
=================================
PASS: 4 SKIP: 0 FAIL: 6


The test results (with the two kernel patches applied) are:

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "")
Result (expect not found): not found

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "exec")
Result (expect found): found

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "read_implies_exec")
Result (expect found): found

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "")
Result (expect not found): not found

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "exec")
Result (expect found): found

Test: check_mmap (hook="MMAP_CHECK_REQPROT", test_mmap arg: "read_implies_exec")
Result (expect not found): not found

Test: check_deny (hook="MMAP_CHECK", test_mmap arg: "mprotect")
Result (expect denied): denied

Test: check_deny (hook="MMAP_CHECK_REQPROT", test_mmap arg: "mprotect")
Result (expect denied): denied

Test: check_deny (hook="MMAP_CHECK", test_mmap arg: "exec_on_writable")
Result (expect denied): denied

Test: check_deny (hook="MMAP_CHECK_REQPROT", test_mmap arg: "exec_on_writable")
Result (expect denied): denied
PASS: 10 SKIP: 0 FAIL: 0

Roberto

