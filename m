Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80DD4BA369
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Feb 2022 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiBQOpi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Feb 2022 09:45:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiBQOpg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Feb 2022 09:45:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985A2B1AB8;
        Thu, 17 Feb 2022 06:45:21 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HEGmXx023779;
        Thu, 17 Feb 2022 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MZCv9jDaF8tMbpoKPFvky5IrVLKNcuChfs2RJ2eknAQ=;
 b=ds969w5lunsJQXmNJyfiTIzM6/3btVsI9rCkKcV/KsPdesgFR1s4n4dlHC7G6DNhfxFc
 dkfUzyA61bKGXZG/OUJYU2bePRuY57dEJpm3J3IPw9+DPESfVNg+HTbuHaPt6gY5uwkn
 jMazG13lrSRQZE4cioy7TgDIg3QErrbYlRfUuvd0xkiPhbBbEZUSzFGMvIk2DLYEHlVb
 h7vba0uN4R0vA89x217XKdonzcOVc6KGzMYiAurq6z1CcJ1jmAD54BWLIIcnsdfR652K
 jLUXsbGLkqQda693JjwzSlL104t0pX4xSWD4Wis31mRx/cV09l49ePcuW1sJYau9VztT VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9r00gne7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:44:50 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HEHSX5025832;
        Thu, 17 Feb 2022 14:44:49 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9r00gnd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:44:49 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HEW485003095;
        Thu, 17 Feb 2022 14:44:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3e64ha96xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 14:44:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HEYIfO45089156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:34:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C0CA4055;
        Thu, 17 Feb 2022 14:44:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 560EEA4057;
        Thu, 17 Feb 2022 14:44:41 +0000 (GMT)
Received: from sig-9-65-66-221.ibm.com (unknown [9.65.66.221])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 14:44:41 +0000 (GMT)
Message-ID: <4186a81dd0b4608b484d95ffbe7b1c026e648e36.camel@linux.ibm.com>
Subject: Re: [PATCH v10 10/27] ima: Move IMA securityfs files into
 ima_namespace or onto stack
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Thu, 17 Feb 2022 09:44:40 -0500
In-Reply-To: <20220201203735.164593-11-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-11-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -9mEjmAddhF_w0A3ack_bC_kVULoMxEy
X-Proofpoint-ORIG-GUID: ES-dT2My7t00WE6igbVY7WJiDmqFDKdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Earlier we simplified how dentry creation and deletion is manged in
> securityfs. This allows us to move IMA securityfs files from global
> variables directly into ima_fs_ns_init() itself. We can now rely on
> those dentries to be cleaned up when the securityfs instance is cleaned
> when the last reference to it is dropped.
> 
> Things are slightly different for the initial IMA namespace. In contrast
> to non-initial IMA namespaces it has pinning logic binding the lifetime
> of the securityfs superblock to created dentries. We need to keep this
> behavior to not regress userspace. Since IMA never removes most of the
> securityfs files the initial securityfs instance stays pinned. This also
> means even for the initial IMA namespace we don't need to keep
> references to these dentries anywhere.
> 
> The ima_policy file is the exception since IMA can end up removing it
> on systems that don't allow reading or extending the IMA custom policy.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>

Really nicely worded patch description.  Thanks!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

