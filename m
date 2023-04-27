Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524EC6F0732
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbjD0OW1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbjD0OWD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 10:22:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586794C37
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 07:21:33 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33REHshD024350
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 14:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=kCrV0avGTuCgcexZVGflEPCt0WHvEZ0J086Q+M4c6po=;
 b=OnIVXrl7fPB1GtWXUNTWtyVK1cW0jOokCCm9n9OaauKZQjtMkzQN6FHbsiMMfZLaxVD6
 B1uXuPWynw1YU5N4xgkEePFhwSE5figjas8OshyWWYL36skvakM7uYbWaA7dUq6SN7Jv
 ZPWCt2sStvSo4Rz2NCgErBwwRjWu9xu+76W+auxovTWMieug3le1GIoKwsVuBrNGMSNm
 PmYbkYuUgBbBQGobIgJKnHq8p6cIaQNlveO+Lx8Kf77golbwl6AuEx5FEL8RXra9lKwU
 jG3EriqKaP73WxaBquZ/ztLn+toGnB3FPJVrZXKSlVrjJKI23wxzPhp9X4oeQcpgoQMO Gw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7tf1112k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 14:21:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33RDeE6a013072
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 14:21:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3q4778arvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 14:21:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33RELPm731523438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 14:21:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2F85805F;
        Thu, 27 Apr 2023 14:21:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31A8758063;
        Thu, 27 Apr 2023 14:21:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.75.56])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Apr 2023 14:21:25 +0000 (GMT)
Message-ID: <a480d58500f49ef569451a4f324413d87689c32b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 0/4] Update README and examples and add
 EC key support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 27 Apr 2023 10:21:24 -0400
In-Reply-To: <20230426223559.681668-1-stefanb@linux.ibm.com>
References: <20230426223559.681668-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8K5SUd41ydOEX7K6Qx0rk2z5Sc0yw91E
X-Proofpoint-ORIG-GUID: 8K5SUd41ydOEX7K6Qx0rk2z5Sc0yw91E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-04-26 at 18:35 -0400, Stefan Berger wrote:
> Update the README and add example scripts for RSA keys to use more up-to-date
> values for key sizes and hash being used and adjust the OpenSSL config files so
> that the created keys can be used with the .machine keyring. Add EC key and cert
> support scripts and describe EC key and certificate generation in the README.

Thanksb, Stefan.  The patches are now queued in next, next-testing.

Mimi

