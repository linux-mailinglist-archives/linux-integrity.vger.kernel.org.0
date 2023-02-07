Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC168DF3F
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBGRsd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjBGRsc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 12:48:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B620A5E0;
        Tue,  7 Feb 2023 09:48:31 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317HDA4i023148;
        Tue, 7 Feb 2023 17:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=I6YqOjsVJXBoVvu3lCwpjBpbkJBlsw5y1jnnvceKMsM=;
 b=U6adYuBVNCAfRTgWMKx/0Y2jmLGJc2m6BEI9mMZQ1VLCp5/E1+gB56ie7HsIMLDaWvhF
 sxBrqrkPXyUT3NFXKc2p/Kt+YIViTGR68M+IyPWU8fv7nNVQTRrlW8EavFaFtsZ0l2vU
 KgMRBuqsum9zmNn0u2RP+AzPW+AaGzOrglHu1VkJQzIBHHbcVwKjMIxVu5CzcfGBfg1m
 YvhcdsA+QJSA8r0L5xIeKVUSy9hN5JD54jvwqpJ64MD8HVUvMMyxMrrCEUDvQA6Jj4NN
 ibW6T3ZM09jR+X+JUJFaSdSeuOeeJ+ZVfLnOUy9vV+hBiLF8IHMYtt+6JJ7SyRBFBnuh TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nks1rwm1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 17:48:01 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HTw9p008558;
        Tue, 7 Feb 2023 17:48:00 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nks1rwm14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 17:48:00 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 317FUpoI027478;
        Tue, 7 Feb 2023 17:47:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07s635-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 17:47:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317HlwMx37945944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 17:47:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4204158061;
        Tue,  7 Feb 2023 17:47:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2114158053;
        Tue,  7 Feb 2023 17:47:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.18.153])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 17:47:57 +0000 (GMT)
Message-ID: <6e01fda2e1f322689123955fcad4d449d036074c.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 07 Feb 2023 12:47:56 -0500
In-Reply-To: <c0ba2244832ea4c95e936674c4e818b26b511d61.camel@huaweicloud.com>
References: <20230203125637.2673781-1-roberto.sassu@huaweicloud.com>
         <cd21f0d2a65f9673a0abe7f0a7219d5f1fe55911.camel@linux.ibm.com>
         <d6efb292273eee6caff9afc8b64e42984a3ae517.camel@huaweicloud.com>
         <c0ba2244832ea4c95e936674c4e818b26b511d61.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yyn4wRD4y_O-zjceXO1hhLnkH_sIOB1v
X-Proofpoint-GUID: dPfBxlvo7wOWyxhMhXZkQyd7AJWjjHAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-02-07 at 17:57 +0100, Roberto Sassu wrote:
> On Tue, 2023-02-07 at 11:16 +0100, Roberto Sassu wrote:
> > On Mon, 2023-02-06 at 08:20 -0500, Mimi Zohar wrote:
> > > On Fri, 2023-02-03 at 13:56 +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Add tests to ensure that, after applying the kernel patch 'ima: Align
> > > > ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> > > > checks the protections applied by the kernel and not those requested by the
> > > > application.
> > > > 
> > > > Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> > > > the MMAP_CHECK_REQPROT hook checks the protections requested by the
> > > > application.
> > > > 
> > > > Test both with the test_mmap application that by default requests the
> > > > PROT_READ protection flag. Its syntax is:
> > > > 
> > > > test_mmap <file> <mode>
> > > > 
> > > > where mode can be:
> > > > - exec: adds the PROT_EXEC protection flag to mmap()
> > > > - read_implies_exec: calls the personality() system call with
> > > >                      READ_IMPLIES_EXEC as the first argument before mmap()
> > > > - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
> > > >             to PROT_READ
> > > > - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
> > > >                     writable mapping
> > > > 
> > > > Check the different combinations of hooks/modes and ensure that a
> > > > measurement entry is found in the IMA measurement list only when it is
> > > > expected. No measurement entry should be found when only the PROT_READ
> > > > protection flag is requested or the matching policy rule has the
> > > > MMAP_CHECK_REQPROT hook and the personality() system call was called with
> > > > READ_IMPLIES_EXEC.
> > > > 
> > > > mprotect() with PROT_EXEC on an existing memory area protected with
> > > > PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> > > > hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> > > > a file with a writable mapping.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Thanks, Roberto.  Other than the one comment below, it looks good.
> > > 
> > > > +
> > > > +if ! awk '$0 ~ /^(measure|appraise)/ && $0 !~ /fsuuid=/ && $0 !~ /fowner=/ { exit 1 }' < /sys/kernel/security/ima/policy; then
> > > > +	echo "${CYAN}IMA policy rules without fsuuid= and fowner=, cannot continue due to possible interference with the tests${NORM}"
> > > > +	exit "$SKIP"
> > > > +fi
> > > 
> > > The test should be limited to just MMAP_CHECK and MMAP_CHECK_REQPROT
> > > policy rules.
> > > 
> > > +if ! awk '$0 ~ /^(measure|appraise)/ && $0 ~ /func=MMAP_CHECK/ && $0 !~ /fsuuid=/ && ...
> > 
> > Oh, yes. Better.
> 
> It seems more complicated than that.
> 
> If we consider only MMAP_CHECK and MMAP_CHECK_REQPROT rules, we might
> miss rules without func= that can potentially overlap.
> 
> Overlap of measure and appraise rules per se should not be a problem,
> unless additional options are specified in the rule. In that case, the
> options of the first matching rule are taken and the other options from
> other rules might not be processed (IMA stops checking the policy when
> it has encountered rules with the possible actions, determined when the
> policy is loaded).
> 
> Also, dont_measure and dont_appraise rules are a possible concern, as
> they could be matched before ours and could change the expected
> outcome.
> 
> A proposal could be to ignore existing rules, regardless of the action,
> if they provide a different value for at least one of the policy
> keywords (in 'base' and 'lsm') present in the rule being added.
> 
> For the rules that we didn't ignore, we can accept them if they have
> the same action and no/the same policy options.

Agreed.   Since this is much more complex than the awk test, I assume
it would need to be a function.  For now keep it in the
mmap_check.test, not functions.sh.

thanks,

Mimi

