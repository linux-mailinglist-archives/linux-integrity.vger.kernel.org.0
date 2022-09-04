Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24D5AC595
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Sep 2022 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiIDRIp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Sep 2022 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiIDRIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Sep 2022 13:08:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A52ED5F
        for <linux-integrity@vger.kernel.org>; Sun,  4 Sep 2022 10:08:43 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284Git0X013875;
        Sun, 4 Sep 2022 17:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=abYkA1LcBSnmyizias0JZCXJfyY6lAeKUQ907eXhx5s=;
 b=Clkfl9fN2NS27PnybyDeltiqirrA3SufLEHAV0z9JGXlijxK59VKBWMjDDGYcmcJLkIL
 ffmWv8f801lH1nXUlpgiEgtS/XWFNw46TG2VS8iufUZ7G1OF3uO/GENBIAlqzDboruWW
 qeQvctp6kFf04JsbXpAQ37V1Qb5Q+hkCCf/75/R+B+mQMiYThkyYRTM/cL7eaHgADq6P
 QukOJ22EVo0PDcnE8q3udZCwuSsIl7bry1TfrLeiA/LB4PNa0oxgKYHZcIQ42HFHHEOh
 KxjNKn4o9B5VxuJ8SUCXWzqIUuEcRSxHLPWduaCKHPuLnpKg6Inu4OeyX78Ed2uA1clg BA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jcyth8apx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 17:08:39 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 284H6LO0008355;
        Sun, 4 Sep 2022 17:08:39 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3jbxj9tfd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Sep 2022 17:08:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 284H8bYO15467102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Sep 2022 17:08:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84D4A6A04D;
        Sun,  4 Sep 2022 17:08:37 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E69C6A04F;
        Sun,  4 Sep 2022 17:08:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.48.194])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun,  4 Sep 2022 17:08:36 +0000 (GMT)
Message-ID: <fb1c4b0e77398d53c8ca06b869ccabb4d66c33a9.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] add support for reading per bank TPM 2.0
 PCRs via sysfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Tergel Myanganbayar <tergel@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Tergel Myanganbayar <tergel@u.northwestern.edu>
Date:   Sun, 04 Sep 2022 13:08:36 -0400
In-Reply-To: <57e1b104-e1bf-de17-3567-6bb148047403@linux.ibm.com>
References: <20220902230815.35448-1-tergel@linux.ibm.com>
         <57e1b104-e1bf-de17-3567-6bb148047403@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dDvl8dOzgw8S0Tq-MJup30-bDrjLbpTT
X-Proofpoint-ORIG-GUID: dDvl8dOzgw8S0Tq-MJup30-bDrjLbpTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=965
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209040087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-09-02 at 21:54 -0400, Stefan Berger wrote:

> > +static int read_tpm2_one_bank(struct tpm_bank_info *tpm_bank, int bank)
> > +{
> > +	FILE *fp;
> > +	char file_name[NAME_MAX];
> > +	char digest[MAX_DIGEST_SIZE + 1];
> > +	char *p;
> > +	int i;
> > +
> > +	for (i = 0; i < NUM_PCRS; i++) {
> > +		sprintf(file_name, "%s%d/%d", tpm2_pcr_path, bank, i);
> 
> ... and just write "/sys/class/tpm/tpm0/pcr-sha%d/%d" here ?

Thanks, Stefan.  Although the only banks currently supported are sha1
and sha256, let's not hard code the hash algorithm.   The tpm_bank_info
struct contains the algo_name.   With this change, there's no need for
the "banks[]" definition in read_sysfs_tpm2_pcrs() or passing it to
read_tpm2_one_bank().

-- 
thanks,

Mimi

