Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3F568B4E
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 16:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiGFOeN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGFOeL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 10:34:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83851836D
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jul 2022 07:34:10 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266CpVpO008264;
        Wed, 6 Jul 2022 14:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CE1VmX7bHoMcrXGqRMXiEj2kc/KDtLm+Dh8bAi9fHYM=;
 b=XCMayTtaBRh04vBZNIK1mfpgz4KVOdwAHWnMQkCHtl2wutAHmkY/gNOsRV2zukLkkYdl
 v0AXBvbcH4hyV14A4N0dMmIPTWhCJzmDhT5Nn2XE0SkWgWE21H36XtqXFyhvOQUuglKo
 hh0OFomGP/cGTtOdXB1HD3v631SiYJqndTdVhJUI+JI7jWiqPK+hFfMhs4fCHZYSh+n4
 FyIlPiz7iCWMxes0KD0cDZyKZkuYWq5l8/ZBk0ZGFhgxfU65sPh7IkMKHg5WrJauXmrL
 65mGWQD8szYkLLB520eAX995NnWJzXln6vYonGAlEh3KXoZnDCfUFuvEZDU6TlqEJRxI 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5as4atcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 14:34:00 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 266E03sa017868;
        Wed, 6 Jul 2022 14:34:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5as4atbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 14:33:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266ELa8U018889;
        Wed, 6 Jul 2022 14:33:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4js88n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 14:33:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266EXstu23855556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 14:33:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B3ADA4040;
        Wed,  6 Jul 2022 14:33:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB3FEA4051;
        Wed,  6 Jul 2022 14:33:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.56.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 14:33:51 +0000 (GMT)
Message-ID: <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Date:   Wed, 06 Jul 2022 10:33:50 -0400
In-Reply-To: <20220706114806.GB2403@willie-the-truck>
References: <20220704015201.59744-1-coxu@redhat.com>
         <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
         <20220706114806.GB2403@willie-the-truck>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8diDWdoI3ABr3hEt6stGkIzHRaRnmt7N
X-Proofpoint-ORIG-GUID: vBAwSuJAH9IkATsrx7hVhlx9r0SE3mah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=889 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
> On Wed, Jul 06, 2022 at 07:35:36AM -0400, Mimi Zohar wrote:
> > On Mon, 2022-07-04 at 09:51 +0800, Coiby Xu wrote:
> > > Currently when loading a kernel image via the kexec_file_load() system
> > > call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
> > > .secondary_trusted_keys and .platform keyrings to verify a signature.
> > > However, arm64 and s390 can only use the .builtin_trusted_keys and
> > > .platform keyring respectively. For example, one resulting problem is
> > > kexec'ing a kernel image  would be rejected with the error "Lockdown:
> > > kexec: kexec of unsigned images is restricted; see man
> > > kernel_lockdown.7".
> > > 
> > > This patch set enables arm64 and s390 to make use of the same keyrings
> > > as x86 to verify the signature kexec'ed kernel image.
> 
> [...]
> 
> > > For arm64, the tests were done as follows,
> > >   1. build 5.19.0-rc2
> > >   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
> > >      db;
> > >   3. sign different kernel images with different keys including keys
> > >      from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
> > >      key and MOK key
> > >   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
> > >      enabled, only the kernel image signed by the key from the
> > >      .builtin_trusted_key keyring can be kexec'ed
> > 
> > Just confirming, for arm64, this patch set allows verifying the
> > kexec'ed kernel image signature using keys on either the .platform or
> > .secondary_trusted_keys keyrings.
> 
> It looks like this series is ready to go, but it's not clear who should
> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
> take it via the arm64 tree (on its own branch) if that would be helpful.

Unless Eric is interested, I was asked to pick this patch set up.

thanks,

Mimi

