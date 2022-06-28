Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052255E3A9
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbiF1Mpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jun 2022 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbiF1Mpt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D41193ED;
        Tue, 28 Jun 2022 05:45:49 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SCScGf014511;
        Tue, 28 Jun 2022 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j6ch0D9CGVi5nh8PrSZAYmkusnozMgd1H3HBZpBxCkw=;
 b=oEx2MSO6y4fpuxdouhV6y0pic4OAs2diSXcqZmSY7yp1pPKXZ7V9GFaXg1XSXllLMlso
 VnEuAFxMPjdagv524DPMKkW1s7zGggjnCCvnu8XDHiaMZ/QPJmQwjCoeoDSXkc+PKEEJ
 WOa6zKE7h2cYOlXCOA7EHEU/IGvdcwFuwC/ZOo0h7DCW9JNZ/THcu9Svf6dRvGeAj8tm
 beg0lsl4AVKanekXaAvOxi04vOnPrIG+BWkFQAA+Btz1g4pO5q7hEBjRXwCZradCa39U
 144tI6fG84SztLfpBAItS7oERyxWDWsVsUk+hoXCQGAxdwxaWqZp58iJxWd97B8PKg5l +A== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h01pb8mge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:45:43 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SCbNmV020632;
        Tue, 28 Jun 2022 12:45:42 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3gwt098127-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:45:42 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SCjfOY33685920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 12:45:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0FBAC05E;
        Tue, 28 Jun 2022 12:45:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07371AC05B;
        Tue, 28 Jun 2022 12:45:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 12:45:40 +0000 (GMT)
Message-ID: <01b52288-7fb4-3b4c-4e47-1f74a839818e@linux.ibm.com>
Date:   Tue, 28 Jun 2022 08:45:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/3] tpm: Preserve TPM measurement log across kexec
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220627223352.GA3082294-robh@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220627223352.GA3082294-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SGPpnHRj-qxe3KVt3yzFdN6iFHbYKRD4
X-Proofpoint-ORIG-GUID: SGPpnHRj-qxe3KVt3yzFdN6iFHbYKRD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/27/22 18:33, Rob Herring wrote:
> On Thu, Jun 16, 2022 at 11:41:27AM -0400, Stefan Berger wrote:
>> The of-tree driver does not currently preserve the IBM vTPM 1.2 and
>> vTPM 2.0 measurement logs across a kexec. This series fixes this for the
>> kexec_file_load() syscall using the flattened device tree (fdt) to
>> carry the measurement log's buffer across kexec.
> 
> As mentioned in v1, please Cc other folks that might care about TPMs
> and kexec. I'm sure it's not only IBM.

That's why I cc'ed the linux-integrity mailing list now where all the 
TPM related development is happening.

    Stefan

> 
> Rob
