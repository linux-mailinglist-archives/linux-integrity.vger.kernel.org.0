Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEF686CFE
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBARae (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 12:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjBARaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 12:30:20 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A886E416;
        Wed,  1 Feb 2023 09:29:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P6THF46wzz9xFH0;
        Thu,  2 Feb 2023 01:21:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dwN8odpjczjmAA--.13664S2;
        Wed, 01 Feb 2023 18:29:40 +0100 (CET)
Message-ID: <4a01d975f20f842284da4f46da4eee8c0091f354.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 01 Feb 2023 18:29:21 +0100
In-Reply-To: <c5d2e56c923645ec6e0ac8de15123c123db271ee.camel@linux.ibm.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
         <c5d2e56c923645ec6e0ac8de15123c123db271ee.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3dwN8odpjczjmAA--.13664S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDGFW5XFWUWr4xCw18AFb_yoW5XFyDpF
        Z5ZFyDtFyvgFy7X3sagF4qvrsayF10yF1UWF9rK34YkFyUCF1xtr47tF1DuFZ7Xr4rZa1v
        va1rAw43Gw1vya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4RsjgAAse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 22:02 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> > +check_mmap() {
> > +	local hook="$1"
> > +	local arg="$2"
> > +	local test_file fowner rule result test_file_entry
> > +
> > +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> > +
> > +	if ! test_file=$(mktemp -p "$PWD"); then
> > +		echo "${RED}Cannot write $test_file${NORM}"
> > +		return "$HARDFAIL"
> > +	fi
> > +
> > +	fowner="$MMAP_CHECK_FOWNER"
> > +	rule="$MEASURE_MMAP_CHECK_RULE"
> > +
> > +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> > +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> > +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> > +	fi
> > +
> > +	if ! chown "$fowner" "$test_file"; then
> > +		echo "${RED}Cannot change owner of $test_file${NORM}"
> > +		return "$HARDFAIL"
> > +	fi
> > +
> > +	check_load_ima_rule "$rule"
> > +	result=$?
> > +	if [ $result -ne "$OK" ]; then
> > +		return $result
> > +	fi
> > +
> > +	test_mmap "$test_file" "$arg"
> > +
> > +	if [ "$TFAIL" != "yes" ]; then
> > +		echo -n "Result (expect found): "
> > +	else
> > +		echo -n "Result (expect not found): "
> > +	fi
> > +
> > +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> > +	if [ -z "$test_file_entry" ]; then
> > +		echo "not found"
> > +		return "$FAIL"
> > +	fi
> 
> Using temporary files should prevent having multiple records.  Having a
> verbose option to show the actual matching measurement list record
> would be nice.
> 
> > +
> > +	echo "found"
> > +	return "$OK"
> > +}
> > +
> 
> 
> > +
> > +# Run in the new environment if TST_ENV is set.
> > +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> > +
> > +# Exit from the creator of the new environment.
> > +_exit_env "$TST_KERNEL"
> > +
> > +# Mount filesystems in the new environment.
> > +_init_env
> > +
> > +if [ "$(whoami)" != "root" ]; then
> > +	echo "${CYAN}This script must be executed as root${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +if [ ! -f /sys/kernel/security/ima/policy ]; then
> > +	echo "${CYAN}IMA policy file not found${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +if ! cat /sys/kernel/security/ima/policy &> /dev/null; then
> > +	echo "${CYAN}IMA policy file is not readable${NORM}"
> > +	exit "$SKIP"
> > +fi
> 
> An existing policy with an mmap rule would affect this test.  Check to
> see if one already exists.

Not sure about this. We are specifying the filesystem UUID and the file
owner. Should be enough to avoid interferences. Also
check_load_ima_rule() avoids duplicated rules.

Roberto

> > +
> > +if [ -n "$TST_KEY_PATH" ]; then
> > +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> > +		echo "${RED}Absolute path required for the signing key${NORM}"
> > +		exit "$FAIL"
> > +	fi
> > 

