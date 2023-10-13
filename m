Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26027C8684
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Oct 2023 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJMNOK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Oct 2023 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNOJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Oct 2023 09:14:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D691;
        Fri, 13 Oct 2023 06:14:07 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDAFWl007578;
        Fri, 13 Oct 2023 13:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Q4Ru+IN6t10itKohqSPNoQRasHDcTJjERh8NX9i3fWE=;
 b=BTaJ358Lewkatyn604ewHMWz7JU1VD9C668cv1sfGqgm6sJLYe5BQ1gjSaVSFJNjf0m8
 PGCstScAfS3/5Q3lwCae6EeRVSKAduf8xe0ZlWTsPoYsfYI/9Pc7sBBhikbx6BjIRNyh
 REXJpkVVU7fKK0HCGx7tsnFMOgrp1TFoPkZYVLWcT869mqGRoHF6JNsL36LidEnFHf9x
 NcPTH9y2atjEYxXpqPz1hqa12nOgNcp2zMK4J7mD5p2NMRmhbnyX3gbnvOCWHEurfXme
 yMMRYtGQKUO55Y9cZqBAFvTuUbHwYf1VThczOtVj47gIOGhYbDKUMnporhZpUB8XOYiV CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6akrs63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:13:29 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DCtVvq008312;
        Fri, 13 Oct 2023 13:12:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6akrrmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:12:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBP87J026010;
        Fri, 13 Oct 2023 13:12:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt54v28r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:12:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39DDCalT9306856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 13:12:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C465805C;
        Fri, 13 Oct 2023 13:12:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F3B58054;
        Fri, 13 Oct 2023 13:12:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.129.99])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Oct 2023 13:12:33 +0000 (GMT)
Message-ID: <6dbb864d2611c58230e3392df0c3bd2e9a700ec8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 16/25] security: Introduce path_post_mknod hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 13 Oct 2023 09:12:33 -0400
In-Reply-To: <20230904133415.1799503-17-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904133415.1799503-17-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WxY_RMohtsYTL9VcKPMDtKL-3ibCw4pC
X-Proofpoint-GUID: _Tqw34oiStwkfV_t2O3EVxzJuQn3EkdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=691 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
> 
> It is useful for IMA to let new empty files be subsequently opened for
> further modification.

(Please remove "It is useful for"  here and in other patch
descriptions.  Will not repeat this again.)

Possible wording:
IMA-appraisal requires all existing files in policy to have a file
hash/signature stored in security.ima.  An exception is made for empty
files created by mknod, by tagging them as new files.

> 
> LSMs can benefit from this hook to update the inode state after a file has
> been successfully created. 

(Please remove "LSMs can benefit from" here and in other patch
descriptions.)

Please make sure that the patch description is in sync with the LSM
hook kernel doc. 

> The new hook cannot return an error and cannot
> cause the operation to be canceled.

(Separate paragaraph)

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

-- 
thanks,

Mimi

