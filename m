Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84943730C08
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jun 2023 02:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjFOAL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjFOAL5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 20:11:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CE2130
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 17:11:55 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENluBx005241;
        Thu, 15 Jun 2023 00:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/JR+Zh3MhLLEO/ov2Okiz6mHsGaTaBHt/mpgIBES2qM=;
 b=Vlor9uMLwTW+pksedOA4/El2mNEBDb4dqLagUnmUF6zW/gNY2emn/oCcLukBXn8h2ufg
 X65XGrV3onYsHAzucEYyGipSnWj9BNvdHpp9HsvldLIRa6pNcPtisXLV8Yc+T/5czngz
 rA4bnJx5sWBkCQpQ7XzQSXA9G4jqmbnZL7hVIwGL75pIjGrvI/6H1QXKXdK+qB0QHGuE
 5zizfbPhJw0ZUZ64uRi45Ae/b6KBRh1DKXyJRT3dIDXYxocerxzWDJr7uOliAm2CowGQ
 7DAguuyNEMfDj9spiQcdHTEw7TrZVb7R54lHxNfyXszRiPnCKizO6OzozY/lS3iHP2a4 Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qh60fpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:11:38 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F0BcIk013025;
        Thu, 15 Jun 2023 00:11:38 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qh60fpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:11:38 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKe5iv010755;
        Thu, 15 Jun 2023 00:11:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5r746-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:11:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35F0Bakk31392344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:11:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6EB65805A;
        Thu, 15 Jun 2023 00:11:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D80E5805E;
        Thu, 15 Jun 2023 00:11:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 00:11:36 +0000 (GMT)
Message-ID: <b1bc537f4969226f03e4c03eb63eb3f27f081503.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 3/4] Add --hmackey option for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 14 Jun 2023 20:11:36 -0400
In-Reply-To: <20230605165554.1965238-4-roberto.sassu@huaweicloud.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
         <20230605165554.1965238-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _0GMddO4m8P-61-KhWqBdavqtTCp201Q
X-Proofpoint-ORIG-GUID: kqb1tU_wLgUYWSBU93HwXumqWC8zhpKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=808 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140211
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-05 at 18:55 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the --hmackey option, to specify an alternate path for the file
> containing the HMAC key. By default evmctl looks in
> /etc/keys/evm-key-plain.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Please include the motivation for this feature.  Otherwise, it looks
good.

-- 
thanks,

Mimi

