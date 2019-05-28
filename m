Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EA2CF47
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 21:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfE1TOt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 15:14:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727755AbfE1TOt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:14:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJDoKn123580
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:14:46 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ss88nq8q5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:14:46 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 May 2019 20:14:45 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 20:14:40 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SJEdot23396840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:14:39 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDD90BE056;
        Tue, 28 May 2019 19:14:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0680BE04F;
        Tue, 28 May 2019 19:14:34 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.218.160])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 28 May 2019 19:14:34 +0000 (GMT)
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-13-bauerman@linux.ibm.com> <1559052560.4090.14.camel@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v10 12/12] ima: Store the measurement again when appraising a modsig
In-reply-to: <1559052560.4090.14.camel@linux.ibm.com>
Date:   Tue, 28 May 2019 16:14:30 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052819-0020-0000-0000-00000EF149D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011176; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209917; UDB=6.00635633; IPR=6.00990946;
 MB=3.00027089; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 19:14:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052819-0021-0000-0000-000066010AC1
Message-Id: <871s0i75nt.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> Hi Thiago,
>
> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> If the IMA template contains the "modsig" or "d-modsig" field, then the
>> modsig should be added to the measurement list when the file is appraised.
>>
>> And that is what normally happens, but if a measurement rule caused a file
>> containing a modsig to be measured before a different rule causes it to be
>> appraised, the resulting measurement entry will not contain the modsig
>> because it is only fetched during appraisal. When the appraisal rule
>> triggers, it won't store a new measurement containing the modsig because
>> the file was already measured.
>>
>> We need to detect that situation and store an additional measurement with
>> the modsig. This is done by adding an IMA_MEASURE action flag if we read a
>> modsig and the IMA template contains a modsig field.
>
> With the new per policy rule "template" support being added, this
> patch needs to be modified so that the per policy "template" format is
> checked. ima_template_has_modsig() should be called with the
> template_desc being used.

Right. Thanks for point out what needs to be done. After rebasing on top
of Matthew Garret's "IMA: Allow profiles to define the desired IMA
template" patch I changed ima_template_has_modsig() to check the
template_desc obtained from process_measurement().

--
Thiago Jung Bauermann
IBM Linux Technology Center

