Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9089569C221
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Feb 2023 20:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBSTmt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Feb 2023 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBSTms (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Feb 2023 14:42:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F895166FE;
        Sun, 19 Feb 2023 11:42:47 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31JJLGPk031041;
        Sun, 19 Feb 2023 19:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1Lm6G//TtEY+92KWMgEexavCALyHAPzjuFrffbAZvAo=;
 b=jRO5tCNxrXC6dRGkv7AKMoRb7AYwy5I3BUuXgMk1tCHYsz/uUv6U3vKMhm9H0VdMeiOX
 wKufqenv5jErM4jkneDshjJJicXKt8LchVrUjjZu+CvGn2KfGiIF0FlYjVb4NUw6euu7
 4ceffMFznYetxdMZVK0gqZjFCa8JcGJZc1Bj4P6ElsgEutZnoep/XdI4q3V6TIhl+YbH
 4Z4b1+PKkw8JGjzA+qGppRpJWLl4iazqVhQi/xtaSBHocW1lvCdiOFormh2Sok7uCn6X
 jZrN7tiXk2Qj+5xdAgASE3p6UtuaLD593YpawValwWO0+6s8898TBriLiW07uaUCCCiP GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nusurg8d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:42:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31JJg0ns023820;
        Sun, 19 Feb 2023 19:42:00 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nusurg8cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:42:00 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JGjlMk029611;
        Sun, 19 Feb 2023 19:41:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ntpa6ubwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:41:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31JJfvP4066200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Feb 2023 19:41:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B2F5804B;
        Sun, 19 Feb 2023 19:41:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A2158055;
        Sun, 19 Feb 2023 19:41:55 +0000 (GMT)
Received: from sig-9-65-218-178.ibm.com (unknown [9.65.218.178])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 19 Feb 2023 19:41:55 +0000 (GMT)
Message-ID: <6b695665f9188087fce6e693d46a7d4088ffebd4.camel@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] security: Remove
 security_old_inode_init_security()
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
Date:   Sun, 19 Feb 2023 14:41:51 -0500
In-Reply-To: <20221201104125.919483-4-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wUDrZozCAT7t_oygBn1y5gjaNJWnr_Ww
X-Proofpoint-GUID: XsRvE-4dIAm2PiedMezVkWV3taphMbSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-19_12,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302190186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> As the remaining two users reiserfs and ocfs2 switched to
> security_inode_init_security(), security_old_inode_init_security() can be
> now removed.
> 
> Out-of-tree kernel modules should switch to security_inode_init_security()
> too.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Once the ocfs2 (2/6) concerns are addressed,
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

