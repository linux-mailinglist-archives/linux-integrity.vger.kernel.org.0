Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7862F8FD
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiKRPM3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiKRPM2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 10:12:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004A13CD0;
        Fri, 18 Nov 2022 07:12:26 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIE7Geb005485;
        Fri, 18 Nov 2022 15:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iMM5oivNJa+sP0gkSNtngKGpdo00X2aXogAjZxh19+U=;
 b=LK5B5/aqHAmRDp8Jdp/8TXCQMA0ZnKxjAHYTOGzTt6aK/tXUyGdojqLqVYmv/o/vFLWf
 lXLwUp7B/CxTLE7Cgrr+KEFeyaKP7WUFT995b5IetCFFJEmBihIddYwTe1UTw/jVcvtO
 YHyquQSDmtpWz30oSuGd4di+GNfnmOthcwzXUrzEUvYMxSit3KiSmTd4FP8S7jUiMi5W
 p0KuF/b4rdAwgdUvmaf0dGlAU33Oe4IG8+YtDxPshUMwNnJZUivmHd4QWHk0jejvDgsW
 lhNCrIP0FXAOfnb85/chpvhIAdmaQukxeQQEnJ38oJ1V/rp45cxI2WeMyKD30n5LmCuk DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx6dx22hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:12:00 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIEvveG018562;
        Fri, 18 Nov 2022 15:12:00 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx6dx22gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:12:00 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIF6qjB015377;
        Fri, 18 Nov 2022 15:11:58 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3kt34ag8fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:11:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIFBuMI66257328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 15:11:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9416058062;
        Fri, 18 Nov 2022 15:11:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3765804E;
        Fri, 18 Nov 2022 15:11:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.49.134])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 15:11:56 +0000 (GMT)
Message-ID: <0f03693fab1b885ffb7ccfb9536028e3d8f25322.camel@linux.ibm.com>
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
Date:   Fri, 18 Nov 2022 10:11:56 -0500
In-Reply-To: <6e4da6d6-5a0c-98ba-9841-07a316f8631e@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-5-roberto.sassu@huaweicloud.com>
         <5ff23992ab249af4fd5ef967691f8986c5898583.camel@linux.ibm.com>
         <6e4da6d6-5a0c-98ba-9841-07a316f8631e@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: akERt5bRzXXE0H8V9EGdmRpTpl36XXhI
X-Proofpoint-ORIG-GUID: xZcY12On9MyUARa0qU19Jqj3vH-7UGYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-18 at 10:30 +0100, Roberto Sassu wrote:
> On 11/17/2022 6:07 PM, Mimi Zohar wrote:
> > On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Change the evm_inode_init_security() definition to align with the LSM
> >> infrastructure, in preparation for moving IMA and EVM to that
> >> infrastructure.
> >>
> >> This requires passing only the xattr array allocated by
> >> security_inode_init_security(), instead of the first LSM xattr and the
> >> place where the EVM xattr should be filled.
> >>
> >> It also requires positioning after the last filled xattr (by checking the
> >> xattr name), since the beginning of the xattr array is given.
> > 
> > Perhaps combine this sentence to the previous paragraph and start the
> > sentence with
> > "In lieu of passing the EVM xattr, ..."
> 
> Ok.
> 
> >> If EVM is moved to the LSM infrastructure, it will use the xattr
> >> reservation mechanism too, i.e. it positions itself in the xattr array with
> >> the offset given by the LSM infrastructure.
> > 
> > The LSM infrastructure will need to support EVM as the last LSM.  Is
> > there a reason for including this comment in this patch description.
> 
> The idea is to first make EVM work like other LSMs, and then add 
> limitations that are EVM-specific.
> 
> As a regular LSM, EVM could be placed anywhere in the list of LSMs. This 
> would mean that whenever EVM is called, it will process xattrs that are 
> set by previous LSMs, not the subsequent ones.
> 
> What we would need to do EVM-specific is that EVM is the last in the 
> list of LSMs, to ensure that all xattrs are protected.
> 
> >> Finally, make evm_inode_init_security() return value compatible with the
> >> inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
> >> setting an xattr.
> > 
> >> EVM is a bit tricky, because xattrs is both an input and an output. If it
> >> was just output, EVM should have returned zero if xattrs is NULL. But,
> >> since xattrs is also input, EVM is unable to do its calculations, so return
> >> -EOPNOTSUPP and handle this error in security_inode_init_security().
> >>
> >> Don't change the return value in the inline function
> >> evm_inode_init_security() in include/linux/evm.h, as the function will be
> >> removed if EVM is moved to the LSM infrastructure.
> >>
> >> Last note, this patch does not fix a possible crash if the xattr array is
> >> empty (due to calling evm_protected_xattr() with a NULL argument). It will
> >> be fixed with 'evm: Support multiple LSMs providing an xattr', as it will
> >> first ensure that the xattr name is not NULL before calling
> >> evm_protected_xattr().
> > 
> >  From my reading of the code, although there might be multiple LSM
> > xattrs, this patch only includes the first LSM xattr in the security
> > EVM calculation.  So it only checks the first xattr's name.  Support
> > for including multiple LSM xattrs in the EVM hmac calculation is added
> > in the subsequent patch.
> 
> I tried to include in this patch just the function definition change and 
> keep the existing behavior.

That's fine.
> 
> The problem is trying to access xattr->name at the beginning of 
> evm_inode_init_security().
> 
> That would disappear in patch 5, where there is a loop checking 
> xattr->value first. Patch 3 disallows combination of NULL name - !NULL 
> value and !NULL name - NULL value. Not sure if the latter is correct 
> (empty xattr?). Will check what callers do.

My comments here and above were for improving the patch description:
- Just say what this patch is doing, not what subsequent changes will
do in the future.  We'll come to that when the time comes.

- Say something only the lines that this patch includes only one LSM
security xattr in the EVM calculation, like previously.

thanks,

Mimi

