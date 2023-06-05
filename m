Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C523722714
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjFENNW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjFENNU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 09:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC91F4;
        Mon,  5 Jun 2023 06:12:50 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355CqWgt010725;
        Mon, 5 Jun 2023 13:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SismmB2jOXNY3RE+Pa8blteeHkwywh0TE1sSJloiJdM=;
 b=K/XjRhAFltU2zziBgfEFYGGbt/R6Hp1E+KhNpwolANOpXwuonWJNgtVLe4Hm78eS1kqs
 lxlvEvqV7RIQ2XP3P7JY2jdMLDFGM1qrzzL4jklVXV01rZe8mDtzhTYFuc3ceEpDyM3M
 +jj5dNGo8C4fI6gp04xlzSO6TyX75+faKKeXPrUdTdCPvz3tniuY2K51/kYIWEUxwDR2
 wRk9ALWyvLNx+Okk3bsyhyMrtIBTBle9FXqYWOJDjcADpPYx5Nw73jwnMh/iXMBZxYu1
 Tib1X2jiGjB4O0bFeZk1Kre7hwItLbHVdVIqjA6b4QF3oWktmwvWNr9yWHNFffBgUCzW qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1g3jrf8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 13:12:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355D8Ldw009129;
        Mon, 5 Jun 2023 13:12:29 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1g3jrf82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 13:12:29 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 355BWUIV026046;
        Mon, 5 Jun 2023 13:12:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qyxnvfef3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 13:12:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 355DCRaL33030404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jun 2023 13:12:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4950E58067;
        Mon,  5 Jun 2023 13:12:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D65758054;
        Mon,  5 Jun 2023 13:12:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.0.86])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jun 2023 13:12:26 +0000 (GMT)
Message-ID: <5560351701e78a0dfb9b7d2eef703395a0d531b0.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Complete description of evm_inode_setattr()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 05 Jun 2023 09:12:25 -0400
In-Reply-To: <c2b7b5531660befc66a25477abc0cc069d08926c.camel@huaweicloud.com>
References: <20230306104036.1298529-1-roberto.sassu@huaweicloud.com>
         <c2b7b5531660befc66a25477abc0cc069d08926c.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VIQZkp-PoCUhq85t2yv6xvEiSp27Ic5H
X-Proofpoint-GUID: SwlhmSYs_Y2IHt1jUEoZTjYCpTQbKKrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=712 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-05 at 13:57 +0200, Roberto Sassu wrote:
> On Mon, 2023-03-06 at 11:40 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the description for missing parameters of evm_inode_setattr() to
> > avoid the warning arising with W=n compile option.
> > 
> > Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm")
> > Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Hi Mimi
> 
> this probably got lost. It was also reviewed by Stefan:
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Could you please take it?

Thanks for the reminder.  In case kernel-doc changes are backported to
stable, I've added # v3.2+ and # v6.3+ respectively to the Fixes lines.

There are two other warnings in EVM.  Any chance you're planning on
fixing them as well?

-- 
thanks,

Mimi



