Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA262F952
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbiKRPds (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiKRPdr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 10:33:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C79F5A8;
        Fri, 18 Nov 2022 07:33:46 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIE7GJS004869;
        Fri, 18 Nov 2022 15:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kj2rDsQz5u6SIg9xdinTFiY5WiCWEqvstO8o92a7tcE=;
 b=V5TKgId/DmXyxpdMVLbxaVVu9rfVpCrtKTxeWfpZ8guSjCmeNuwJhYWnk4Fl04x4XkMO
 TRfTQeyo/RUxwP19wi/g2OOvrEskklkdhZKSW6DaQPUZnNt2tUGSWG15v6A5YdIuuj/v
 5Oi4FVvobE3EgjyhGheJ9QDCzhP9nq++wHPclLCeVnq9sE9xvD3o+ItEtq1WDj9irgr4
 ZvCkm3S9KVOmeXlNpyFW73lrgCITGonv9zBxzxjY+tkaEuIwNYdlnCzmqqRs6PAxa8uA
 Aumv7raOAaXi+UdoGbnR0zYINQJtO9M3HQFkuWOCKXzQvRhnUij8/oN7HEC6KwqfNSb4 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx7sv05ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:33:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIFNTmd004429;
        Fri, 18 Nov 2022 15:33:25 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx7sv05js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:33:25 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIFTvKW005500;
        Fri, 18 Nov 2022 15:33:23 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3kt34ajae0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:33:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIFXMPw20906586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 15:33:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 342FA5806A;
        Fri, 18 Nov 2022 15:33:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EDF85805C;
        Fri, 18 Nov 2022 15:33:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.49.134])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 15:33:20 +0000 (GMT)
Message-ID: <f20e7ff3c6c3aa445faa01d12800a9675a77f102.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 18 Nov 2022 10:33:19 -0500
In-Reply-To: <2e493258-b267-b8ad-0812-53f4e9c849ae@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
         <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
         <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
         <2e493258-b267-b8ad-0812-53f4e9c849ae@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fmVb6IzBeCRCZHKlOYPZxUTS0IK-ggVE
X-Proofpoint-GUID: nbT0swbd0VVqMNRdr9wOygUn7Qqg-Kis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=588 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211180090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-18 at 10:32 +0100, Roberto Sassu wrote:
> > Smack uses multiple xattrs. All file system objects have a SMACK64
> > attribute, which is used for access control. A program file may have
> > a SMACK64EXEC attribute, which is the label the program will run with.
> > A library may have a SMACK64MMAP attribute to restrict loading. A
> > directory may have a SMACK64TRANSMUTE attribute, which modifies the
> > new object creation behavior.
> > 
> > The point being that it may be more than a "nice idea" to support
> > multiple xattrs. It's not a hypothetical situation.
> 
> Ok, that means that I have to change the number of xattrs reserved by 
> Smack in patch 3.

Based on evm_config_default_xattrnames[], there are 4.  There's the
original SMACK and these 3 additional ones.

Mimi



