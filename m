Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C75606921
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 21:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJTTwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJTTwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 15:52:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6C1FAE6D;
        Thu, 20 Oct 2022 12:52:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KJlcts007371;
        Thu, 20 Oct 2022 19:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OLIu2NSMK/vk5UMVeqN8Ey0SJMx222pTWlN8hTualag=;
 b=HcNDZjr9cy2+fh6wbdLzarWrshIWexK6Fdg0vP2jrZk1SEjm7rppVIHwMHPE7hKEwBSB
 AL/L4HmjXed6mj97I8pb2/+7NQuOsdL9oSvsuX5s6RHJnlWqlQZPsGlcyjUaKpCUVTCi
 FM/ikYhLe3WyvAxyeL3dYFMh93jFdlOyge9kyQN4sAZxJZzLjb3xS2PfiPhMizySBb2V
 nYcOkMZ0Itj3zq3c2xCSmiBBHkvq9HFcc2qbe8jtKVbdNzJhsKNqRVt+SQW09CBJl5SG
 M+hg9nzD9ic0/TORnzcHCwzWJTJLMZkSz+YHcsaiyQOVfCvsfN4XmRqSo8yNg6mB9ZiJ rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbct4g3qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 19:51:43 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29KJpggv029619;
        Thu, 20 Oct 2022 19:51:42 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbct4g3pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 19:51:42 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29KJcCF9021442;
        Thu, 20 Oct 2022 19:51:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3k7mgaa750-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 19:51:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29KJphek49349056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 19:51:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D21D358052;
        Thu, 20 Oct 2022 19:51:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BB65804C;
        Thu, 20 Oct 2022 19:51:38 +0000 (GMT)
Received: from sig-9-65-203-47.ibm.com (unknown [9.65.203.47])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 19:51:38 +0000 (GMT)
Message-ID: <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
        linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org
Date:   Thu, 20 Oct 2022 15:51:38 -0400
In-Reply-To: <Y1FTSIo+1x+4X0LS@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XvsbPHNgzMzsIzyolVM1K1ZtCs_sY_Mc
X-Proofpoint-ORIG-GUID: BtqlKIjye2StOvuwh5MNOmNqYlqehmSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_10,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210200118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-20 at 15:55 +0200, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Fixes a NULL pointer dereference occuring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.
> 
> Adds a `call_int_hook_xattr` macro that fetches and feed the
> `new_xattrs` array with every called hook xattr values.
> 
> Adds a `evm_init_hmacs` function which init the EVM hmac using every
> entry of the array contrary to `evm_init_hmac`.
  
Only EVM portable digital signatures include all of the protected
xattrs.   Refer to commit 8c7a703ec978 ("evm: Verify portable
signatures against all protected xattrs").

> 
> Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.

Won't this break existing EVM hmac usage?

-- 
thanks,

Mimi

