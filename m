Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72062B100
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 03:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKPCE3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 21:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKPCE2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 21:04:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFAA12A88
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 18:04:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG13cok008562
        for <linux-integrity@vger.kernel.org>; Wed, 16 Nov 2022 02:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ljbnPLXFzyTeCCH0dx7OIK8iasP9ARqCQR7fFJlMez0=;
 b=Trc0bGWaNAicfJR5phVMgut1Jq5QeEa1u2vaHOfaiozV4StTug3oxPpaAalswnKLAWEW
 y1bHJhM8uUyO2QdpNjZDtiPosubFUH01/rKjdR/AUgGqFmQqAiFiL+OdRJwSyHr90Ni+
 h0BNtlXJo18ClGk6/eOnFdnddhybAf+nfhdLDS2WZNtcnThAgPz//Mg92U/C5m5dq0p6
 ht1YYMp0Xmw71WThHXjx/GwSGBwXphifIpk3Mof9IDLkgulNc6UxnAfzfbk9cyPmjxbd
 hCoBQu9brfu/vRIVaFowkMk56UOjGK13h4rVgczau80fYe7sP/+p40dOzWMhwYBvej/m UA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvnv993ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 Nov 2022 02:04:26 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG1pPIH014096
        for <linux-integrity@vger.kernel.org>; Wed, 16 Nov 2022 02:04:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3kt349wp86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 Nov 2022 02:04:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AG24OEk30343438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 02:04:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 497B75806F;
        Wed, 16 Nov 2022 02:04:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86CE58059;
        Wed, 16 Nov 2022 02:04:23 +0000 (GMT)
Received: from sig-9-65-225-161.ibm.com (unknown [9.65.225.161])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 02:04:23 +0000 (GMT)
Message-ID: <87864bb8cfe8942ed6d55d4186a66fca1086c3ad.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v1 0/4] Fix some issues in evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 15 Nov 2022 21:04:23 -0500
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8myvZfifyzetcT0PPtnutn3S9hQllNr-
X-Proofpoint-ORIG-GUID: 8myvZfifyzetcT0PPtnutn3S9hQllNr-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Wed, 2022-11-02 at 14:45 -0400, Stefan Berger wrote:
> This series of patches fixes memory leaks related to tpm_bank_info
> allocations and entry.template as well as gcc compiler warnings
> when building with -fanalyzer (gcc 12.2.1).
> 
> This series is intended to be applied on top of Mimi's current series
> at https://github.com/mimizohar/ima-evm-utils/tree/next-testing .
> 
>    Stefan
> 
> Stefan Berger (4):
>   Fix memory leaks of tpm_bank_info allocations
>   Fix memory leak related to entry.template
>   Add assert to ensure that algo_name in bank is set
>   Change condition to free(pub)

Thanks, Stefan.  The patches applied to the next/next-testing branches.
In the future, no matter how trivial the patch is, please include patch
descriptions.

thanks,

Mimi

