Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A862E2F2
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 18:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiKQRZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 12:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiKQRZa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 12:25:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68645A0B;
        Thu, 17 Nov 2022 09:25:29 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHAHPS021262;
        Thu, 17 Nov 2022 17:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=suLEoiSZqoI/ONg4Oq+RZpcdAxea8urstYGtfJ4HZ18=;
 b=sZC5GSEN4COtNf8WRFGteiIKAAbYmLFmU/O50i0E5uVz7bdfrTUiXlfYORZ5SKje5hRe
 w7Ne9WMPSMYFTD38KBTdmOjV26iKT4BDX2Fwkki9OXR516iOXVP2F41K35gT5wQ8+qyr
 2rFhq23WOyJjtHDBYbGCX2ssINIcGpntkMYRPUAvF4Ry/evIGIPtevxxeEqaoCrcn4n7
 2JgiQoLbs87ZmJnjDWHuWvnF3CtjHWSzPllIXmKTsPSeMPDndQnSPlDQ8kAhVwK5s0+U
 RF3+N7ccplGx4iVS7IBtkR0JO+qR2XfVY4Fr8/2j5SuVLOsnnReCOhOabUF5oiYbor+U fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwrx48j0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:24:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHHC45k027831;
        Thu, 17 Nov 2022 17:24:58 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwrx48j05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:24:58 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHH4t7u000476;
        Thu, 17 Nov 2022 17:24:57 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3kt349tkdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:24:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHHOrga45548010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:24:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02AAC58059;
        Thu, 17 Nov 2022 17:24:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD4C958043;
        Thu, 17 Nov 2022 17:24:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.240])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 17:24:54 +0000 (GMT)
Message-ID: <6b4d47765a4ddcfdf07158f3ad0737fa3aa5823e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 17 Nov 2022 12:24:54 -0500
In-Reply-To: <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
         <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
         <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fpSioghH0RFkWuopp8jYOt8pezhX03tV
X-Proofpoint-GUID: arArzTbFTFnuHFxLo4w1t1eyMUOnEW6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=946 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-17 at 09:18 -0800, Casey Schaufler wrote:
> On 11/17/2022 8:05 AM, Mimi Zohar wrote:
> > hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Currently, security_inode_init_security() supports only one LSM providing
> >> an xattr and EVM calculating the HMAC on that xattr, plus other inode
> >> metadata.
> >>
> >> Allow all LSMs to provide one or multiple xattrs, by extending the security
> >> blob reservation mechanism. Introduce the new lbs_xattr field of the
> >> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> >> needs, and the LSM infrastructure knows how many xattr slots it should
> >> allocate.
> > Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
> > doesn't currently support it.  The LSM xattrs are hard coded in
> > evm_config_default_xattrnames[],  based on whether the LSM is
> > configured.  Additional security xattrs may be included in the
> > security.evm calculation, by extending the list via
> > security/integrity/evm/evm_xattrs.
> 
> Smack uses multiple xattrs. All file system objects have a SMACK64
> attribute, which is used for access control. A program file may have
> a SMACK64EXEC attribute, which is the label the program will run with.
> A library may have a SMACK64MMAP attribute to restrict loading. A
> directory may have a SMACK64TRANSMUTE attribute, which modifies the
> new object creation behavior.
> 
> The point being that it may be more than a "nice idea" to support
> multiple xattrs. It's not a hypothetical situation.

And each of these addiitonal Smack xattrs are already defined in 
evm_config_default_xattrnames[].

Mimi

