Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF93062E2E3
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiKQRVD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 12:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbiKQRUv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 12:20:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30711A29;
        Thu, 17 Nov 2022 09:20:49 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGQnGV028348;
        Thu, 17 Nov 2022 17:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dbeCS5z5uwKHYW5W10xxyjg+JMgfatHOlOh4tIm49WA=;
 b=nuq6G+NbfYF0MbTQzOrgSUHYbq2YoW5bDz7ZvAkiRb8UsWPWsjgN6NCuIdXaTlLHKVT1
 0ISNvLEfRF4ef5aCtGoonsg3cOLbxZzZWjtYwzKOoSCf8jBQsxWWzzQSWtyj0Jxx+zet
 IxdrsOYI/xHAXKbIkYGmgv5YNymw0+jaMOeKZp0GW/H1ND225nP2rXyV+xueVWJxVBJD
 orxUCUVqMjdRTQWaTo0OunCO3mgHhTgdFUJx2dsn/3zNTqzSbsA+MGPktHTEzzVHgO65
 Rn/Wo4YGE5KmWCFdL5YH04jntguc2VnM4jWY2/aUgFMhcjk7aV3z6JNkNrp94SSk+7Yf mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwrg1hgcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:20:30 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHH87B4006773;
        Thu, 17 Nov 2022 17:20:30 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwrg1hgak-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:20:30 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHH6iQX014297;
        Thu, 17 Nov 2022 17:07:33 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3kt34a2ext-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:07:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHH7Wxj36110994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:07:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62B2F5805F;
        Thu, 17 Nov 2022 17:07:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 772ED58043;
        Thu, 17 Nov 2022 17:07:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.240])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 17:07:31 +0000 (GMT)
Message-ID: <5ff23992ab249af4fd5ef967691f8986c5898583.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 17 Nov 2022 12:07:31 -0500
In-Reply-To: <20221110094639.3086409-5-roberto.sassu@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NZ4_4JP8gCG5bZz7bAQ2pjlJe6FkKkTH
X-Proofpoint-GUID: 0AySCN0lgOw5godZ8faQqgVdZdI-z84F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change the evm_inode_init_security() definition to align with the LSM
> infrastructure, in preparation for moving IMA and EVM to that
> infrastructure.
> 
> This requires passing only the xattr array allocated by
> security_inode_init_security(), instead of the first LSM xattr and the
> place where the EVM xattr should be filled.
> 
> It also requires positioning after the last filled xattr (by checking the
> xattr name), since the beginning of the xattr array is given.

Perhaps combine this sentence to the previous paragraph and start the
sentence with
"In lieu of passing the EVM xattr, ..." 

> If EVM is moved to the LSM infrastructure, it will use the xattr
> reservation mechanism too, i.e. it positions itself in the xattr array with
> the offset given by the LSM infrastructure.

The LSM infrastructure will need to support EVM as the last LSM.  Is
there a reason for including this comment in this patch description.

> Finally, make evm_inode_init_security() return value compatible with the
> inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
> setting an xattr.

> EVM is a bit tricky, because xattrs is both an input and an output. If it
> was just output, EVM should have returned zero if xattrs is NULL. But,
> since xattrs is also input, EVM is unable to do its calculations, so return
> -EOPNOTSUPP and handle this error in security_inode_init_security().
> 
> Don't change the return value in the inline function
> evm_inode_init_security() in include/linux/evm.h, as the function will be
> removed if EVM is moved to the LSM infrastructure.
> 
> Last note, this patch does not fix a possible crash if the xattr array is
> empty (due to calling evm_protected_xattr() with a NULL argument). It will
> be fixed with 'evm: Support multiple LSMs providing an xattr', as it will
> first ensure that the xattr name is not NULL before calling
> evm_protected_xattr().

From my reading of the code, although there might be multiple LSM
xattrs, this patch only includes the first LSM xattr in the security
EVM calculation.  So it only checks the first xattr's name.  Support
for including multiple LSM xattrs in the EVM hmac calculation is added
in the subsequent patch.

thanks,

Mimi

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

