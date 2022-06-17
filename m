Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975FF54FD76
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jun 2022 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiFQTW3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jun 2022 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiFQTW0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jun 2022 15:22:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633C5131C
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jun 2022 12:22:25 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HI3naP021923;
        Fri, 17 Jun 2022 19:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MZS/AORRmqXhsm5G6SSCLjP2ATGAgycyUW4sdwkxi6k=;
 b=ESApNXJJZdlAvbC2g2pPc5glYPNtYYg+vrh0btMKxW/3m9IlM+YMlCT6N3zoJosrPv4r
 9t4uCfChw/V1CNDEUT1v9MRrFtvcxA3SWWeD9y0rrLrDldsCPpmnBMZ1rIOd1LfNJoHp
 l6xDFU/0TE5n9YwaDzCe5tBuLEJta+NM6TNyQ/YIievImk/LAenTEmKxX3limaP7ckEQ
 SHfe7Hp9zD/bMxcmT3sU7jOYqrLk9fYGdQ05oTCPiQjXGNMkA5GnjImL1RUcGFEorLgC
 f3BVWqwB0gqpDUcaaHZaess59qTPRUr0XgduL4S6VdcXitxP/6+fCC1BkRY8s6DJF5Af zw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3grxf6hs6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:22:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HJLIRY014367;
        Fri, 17 Jun 2022 19:22:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3gmjp996a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:22:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HJMHTN18940168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 19:22:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A844203F;
        Fri, 17 Jun 2022 19:22:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E958142041;
        Fri, 17 Jun 2022 19:22:16 +0000 (GMT)
Received: from sig-9-65-64-10.ibm.com (unknown [9.65.64.10])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jun 2022 19:22:16 +0000 (GMT)
Message-ID: <ca1dcedd95954e78ca33d0c3a9b715b699e1700d.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ci/ubuntu: impish -> jammy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date:   Fri, 17 Jun 2022 15:22:16 -0400
In-Reply-To: <20220617135625.2370-1-pvorel@suse.cz>
References: <20220617135625.2370-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mBnTtD2fyJy1bS1fIaVLcoMNi_wNJua7
X-Proofpoint-GUID: mBnTtD2fyJy1bS1fIaVLcoMNi_wNJua7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_13,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Fri, 2022-06-17 at 15:56 +0200, Petr Vorel wrote:
> Ubuntu 21.10 impish EOL in 2027-04 (next month).
> Replace it with the latest stable release (EOL 2027-04).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.  I'll queue this in next-testing.
> ---
> Hi Mimi,
> 
> Tested: https://github.com/pevik/ima-evm-utils/actions/runs/2515784254
> 
> It's also a question whether use 20.04 LTS focal instead of 18.04 LTS
> bionic. I guess we'd like to cover everything: bleeding edge, used
> distros and very old and still used distros. bionic EOL next year
> (2023-04).
> 
> I'll try to have look on Alpine failure sometimes on July.

Thanks, I really appreciate it.  As discussed, it isn't finding the
"tests" directory.

Mimi

