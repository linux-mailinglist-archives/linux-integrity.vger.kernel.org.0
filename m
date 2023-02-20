Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9FF69CB3F
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBTMoe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 07:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjBTMoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 07:44:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557061CAC3;
        Mon, 20 Feb 2023 04:44:09 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCUTwY027235;
        Mon, 20 Feb 2023 12:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RjFiIL2vWgM7tyrPIzie4SN6UpJPtmIUWHUc+QpTxjc=;
 b=pc7eJe6H4AvhAHMxn++6uGWF1g7J+9JXzTOhLh8tpEXZCg3xL9Et43K6QhpMtShldcg0
 VWlfCjbGzxtdCpe+5Hbxz+tmk2gqQHRw6Mp3L45SISfSb9z5b0hhJ0+wCPIrozNC1xoo
 e7GOCKAAeV2GQ182WX57HHKFZcnCB+xK9vdvslbyflieZYUpxUcKwMnjEnKxTcspIetN
 vHSJoR+fgF3F+VMaMv90Dn3jofybEF28li3MwKDvZOfaqDisw6GiCNLALZBU2zm7uIi7
 C43zBNiZpksGSYZ7Rdb8S1UglV2FzuTg1m6MQ4zLTRVCFH3Wy1lXwJyVu1aCkIbCqaeI +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6yhb203-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:43:35 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KCUVoI027631;
        Mon, 20 Feb 2023 12:43:34 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6yhb1ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:43:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KAD7rv017113;
        Mon, 20 Feb 2023 12:43:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ntpa6rfgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:43:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KChWTM30867742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 12:43:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2140958043;
        Mon, 20 Feb 2023 12:43:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A951F58059;
        Mon, 20 Feb 2023 12:43:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 12:43:30 +0000 (GMT)
Message-ID: <22f48112c2fbc2812317c33af13accb022e9abdf.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 20 Feb 2023 07:43:24 -0500
In-Reply-To: <20221201104125.919483-5-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K7hGM2h6oR1A82rQCMEJDAP0VOZ_N6-J
X-Proofpoint-ORIG-GUID: rL7wdt3XJSR_9DKZ19sRZI-wCCQD_ymc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_09,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=741 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Currently, security_inode_init_security() supports only one LSM providing
> an xattr and EVM calculating the HMAC on that xattr, plus other inode
> metadata.
> 
> Allow all LSMs to provide one or multiple xattrs, by extending the security
> blob reservation mechanism. Introduce the new lbs_xattr field of the
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.
> 
> Dynamically allocate the xattrs array to be populated by LSMs with the
> inode_init_security hook, and pass it to the latter instead of the
> name/value/len triple. Update the documentation accordingly, and fix the
> description of the xattr name, as it is not allocated anymore.
> 
> Since the LSM infrastructure, at initialization time, updates the number of
> the requested xattrs provided by each LSM with a corresponding offset in
> the security blob (in this case the xattr array), it makes straightforward
> for an LSM to access the right position in the xattr array.
> 
> There is still the issue that an LSM might not fill the xattr, even if it
> requests it (legitimate case, for example it might have been loaded but not
> initialized with a policy). Since users of the xattr array (e.g. the
> initxattrs() callbacks) detect the end of the xattr array by checking if
> the xattr name is NULL, not filling an xattr would cause those users to
> stop scanning xattrs prematurely.
> 
> Solve that issue by introducing security_check_compact_filled_xattrs(),
> which does a basic check of the xattr array (if the xattr name is filled,
> the xattr value should be too, and viceversa), and compacts the xattr array
> by removing the holes.
> 
> An alternative solution would be to let users of the xattr array know the
> number of elements of that array, so that they don't have to check the
> termination. However, this seems more invasive, compared to a simple move
> of few array elements.
> 
> security_check_compact_filled_xattrs() also determines how many xattrs in
> the xattr array have been filled. If there is none, skip
> evm_inode_init_security() and initxattrs(). Skipping the former also avoids
> EVM to crash the kernel, as it is expecting a filled xattr.
> 
> Finally, adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to correctly fill the designated slots in the
> xattr array. For Smack, reserve space for the other defined xattrs although
> they are not set yet in smack_inode_init_security().
> 
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

