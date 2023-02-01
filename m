Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB10368676C
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjBANtK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 08:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBANtG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 08:49:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFB5A822;
        Wed,  1 Feb 2023 05:48:53 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311DhEhn015142;
        Wed, 1 Feb 2023 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RoooSQW/aSqfoxxsEZakOyZwwnHe9dfDnlvgWRxa7bc=;
 b=dBnNOUBiYbut+2wMqRIrIpJi128PzZRiLoZnBWmYNBCnaDgRAaxqWgdopBeviltZqmlO
 4Zdv0JtFBU4bjGQKI+p5wnsiQaY0vUzpJkzTIXh35dNdNnXXkNgXns1xtLBX7BgpJ0n0
 yNRi7lio+nnllRqzRNzsM7z4GmjgAk7R3givSTSXhEBisGNA1M+cf4YrEq6JYFSBaR39
 eY4BRrvwpAi8PObuignkd3pnfaP/UpGai5LjlroGos5K/clahGF0nU94vB9gTS8jDn0C
 dxB4pSDLYnJva5W8aMuOziESxKggV87D8KzAAX+2/uP5DeXUg8h/Zqloeu+esjqbre9c 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfs71r4m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 13:48:25 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 311Dimgm020527;
        Wed, 1 Feb 2023 13:48:25 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfs71r4kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 13:48:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311Cp6jn008447;
        Wed, 1 Feb 2023 13:48:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2uewt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 13:48:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311DmMPf41812404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 13:48:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD9735805F;
        Wed,  1 Feb 2023 13:48:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06BA75805A;
        Wed,  1 Feb 2023 13:48:22 +0000 (GMT)
Received: from sig-9-77-155-160.ibm.com (unknown [9.77.155.160])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 13:48:21 +0000 (GMT)
Message-ID: <f4c90a817018756398de7ab24d7e5068747de2b2.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 01 Feb 2023 08:48:21 -0500
In-Reply-To: <6a98beea4607a9684789e862b4182dfdf3bec8de.camel@linux.ibm.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
         <6a98beea4607a9684789e862b4182dfdf3bec8de.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mASJrrrJsk6D3R4zGPgUnNeAknFc8N9n
X-Proofpoint-ORIG-GUID: x9lfAGU8izPBiF1l_gEPfu3CeGD27pOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=829 priorityscore=1501
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 19:00 -0500, Mimi Zohar wrote:
> On Tue, 2023-01-31 at 18:42 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add tests to ensure that, after applying the kernel patch 'ima: Align
> > ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> > checks the protections applied by the kernel and not those requested by the
> > application.
> > 
> > Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> > the MMAP_CHECK_REQPROT hook checks the protections requested by the
> > application.
> > 
> > Test both with the test_mmap application that by default requests the
> > PROT_READ protection flag. Its syntax is:
> > 
> > test_mmap <file> <mode>
> > 
> > where mode can be:
> > - exec: adds the PROT_EXEC protection flag to mmap()
> > - read_implies_exec: calls the personality() system call with
> >                      READ_IMPLIES_EXEC as the first argument before mmap()
> > - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
> >             to PROT_READ
> > - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
> >                     writable mapping
> > 
> > Check the different combinations of hooks/modes and ensure that a
> > measurement entry is found in the IMA measurement list only when it is
> > expected. No measurement entry should be found when only the PROT_READ
> > protection flag is requested or the matching policy rule has the
> > MMAP_CHECK_REQPROT hook and the personality() system call was called with
> > READ_IMPLIES_EXEC.
> > 
> > mprotect() with PROT_EXEC on an existing memory area protected with
> > PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> > hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> > a file with a writable mapping.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Nice!   Including some comments, or at least the test assumption, would
> help simplify reviewing the code.

An example of a test assumption, or background information, for the
"mprotect" test is described in the ima_file_mprotect() function
comment:

 * Files can be mmap'ed read/write and later changed to execute to circumvent
 * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
 * would be taken before i_mutex), files can not be measured or appraised at
 * this point.  Eliminate this integrity gap by denying the mprotect
 * PROT_EXECUTE change, if an mmap appraise policy rule exists.

-- 
thanks,

Mimi

