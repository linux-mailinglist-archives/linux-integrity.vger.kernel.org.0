Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B716F458D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjEBNvz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjEBNvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 09:51:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D5A6
        for <linux-integrity@vger.kernel.org>; Tue,  2 May 2023 06:51:45 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342De3uo023398;
        Tue, 2 May 2023 13:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5xbpDhWGwOs34eHJYLAShrV+QByhvOCuibDQffs37t0=;
 b=JHFiP7JUs9ZIdD0c4o1Z0qon6e+ZWiGGWN1pCm3viCal+RosnpeXatM1+tyoKckdCxAx
 UBAOSpyQYOTbXjH3o2MZZUfpnYJrDWJm987bSU+njOhErc/F6NXUC/7QL4FKROvAgKy1
 Yc28ubcc6qcST0tJebs+sZY5gmTGauAviW1LX+iVnAu9DCSj4wlpN+RHc6cg4Q0ulSzl
 g7O+5zOQM67uVuXd1tdkKfy/Azz0sr7LCNFvgxQZ6Wm8OL3puV2+gh65PUjdTtvEh6le
 yOqbQIuu+IZPcEPUz0DC4QYuS5OjHT5lEXbDnq3CJxccMQtI9rfJI1YJ8OZ82iGMso4R 5w== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb2ge2s7q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:51:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342BCamb002628;
        Tue, 2 May 2023 13:36:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv87jgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:36:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342DaCNG11862538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 13:36:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B77958059;
        Tue,  2 May 2023 13:36:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CD1E5805D;
        Tue,  2 May 2023 13:36:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 13:36:12 +0000 (GMT)
Message-ID: <70b507f8-aa4d-2efc-a183-790bee0c8ed5@linux.ibm.com>
Date:   Tue, 2 May 2023 09:36:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v1 0/1] ima: obtain child measurement list from init
 namespace
Content-Language: en-US
To:     Denis Semakin <denis.semakin@huawei.com>,
        linux-integrity@vger.kernel.org
Cc:     artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com,
        ilya.hanov@huawei-partners.com, yusongping@huawei.com,
        hukeping@huawei.com, denis.semakin@huawei-partners.com
References: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
 <20230329085848.278269-1-denis.semakin@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230329085848.278269-1-denis.semakin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 92RD1TtFLsti6cxcCh8_1rj4HptDVAw1
X-Proofpoint-ORIG-GUID: 92RD1TtFLsti6cxcCh8_1rj4HptDVAw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=612 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020115
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 3/29/23 04:58, Denis Semakin wrote:
> This patch allows to read measurement lists of child namespaces
> form init IMA namespace in order to obtain the values of hashes
> to perform operations and procedures of remote attestation.

I supposed this type of support would go onto the next stage (current posted
'stage' is auditing support, next would be measurement support)?

   Stefan

> 
> Denis Semakin (1):
>    ima: obtain child measurement list from init namespace
> 
>   security/integrity/ima/ima.h             |   1 +
>   security/integrity/ima/ima_fs.c          | 164 ++++++++++++++++++++++-
>   security/integrity/ima/ima_init_ima_ns.c |   2 +
>   security/integrity/ima/ima_ns.c          |  31 +++++
>   4 files changed, 193 insertions(+), 5 deletions(-)
> 
