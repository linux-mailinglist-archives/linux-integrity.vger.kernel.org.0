Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45316174CD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 04:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKCDN5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCDNw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 23:13:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15D1131
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 20:13:49 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A32trLp025473;
        Thu, 3 Nov 2022 03:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4I8P/unk0I2480itqewlnsuI1QqQkNKbCMoibyGekdU=;
 b=Ec9DRFM7JTVKPlHcYcFG79rAHotgA4Q58WYB0x81MqWrgURdTH0DIlr3AKa27JJUTvQn
 6hGMQUAaurKBzD6Q/mRyMxSajjOF8sNXcz5487NG8b/TiQRDQjcFsZw2GEbJ8J7W6SNn
 Pl60PuhM/mIVKeZJsdZPBtjKD6WSE4WAneFmMPhSDSrUQ11sTV4h2kEDMkizH1mLiXJ2
 M79Cwg75HfK80BA5eHecvr2Uibkp25T5AQxaCB8g32WjVILxQxD5E94arQ8+FOaOqrVC
 rUJmEwf9KUvnJbDF0cqtKXs7Fi0jpYOqSe5fC5zVi13OZKJ8gkiknL7fw71CuhodGy+W 9A== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3km59wgh00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:13:44 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A335m0w024974;
        Thu, 3 Nov 2022 03:13:43 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3kgutaercs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 03:13:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A33DgfZ524868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 03:13:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B688258068;
        Thu,  3 Nov 2022 03:13:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38AF35805B;
        Thu,  3 Nov 2022 03:13:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.102.239])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 03:13:42 +0000 (GMT)
Message-ID: <6259ee493d9fc389fe0022a70e95d58036b4b56e.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4 02/17] log and reset 'errno' after
 failure to open non-critical files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 02 Nov 2022 23:13:40 -0400
In-Reply-To: <acaaf8eb-431e-fc73-78da-40507d56e6d8@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
         <20221101201803.372652-3-zohar@linux.ibm.com>
         <acaaf8eb-431e-fc73-78da-40507d56e6d8@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CpobXkLQcNAaQzs4nrIRTtVj5s664o-0
X-Proofpoint-GUID: CpobXkLQcNAaQzs4nrIRTtVj5s664o-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=666 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-02 at 17:02 -0400, Stefan Berger wrote:
> 
> On 11/1/22 16:17, Mimi Zohar wrote:
> > Define a log_errno_reset macro to emit the errno string at or near the
> > time of error, similar to the existing log_errno macro, but also reset
> > errno to avoid dangling or duplicate errno messages on exit.
> > 
> > The initial usage is for non-critical file open failures.
> 
> After looking just at the fopen() in evmctl.c at the end of this
> series there are some that are left over that show no error message
> (read_binary_bios_measurements) others that still use log_err() then.
> Should they not all be converted/extended and use log_errno_reset()?
> 

No, log_errno_reset() is meant for the specific case where the program
continues to execute, but the errno message is delayed and emitted on
program exit.  In the case of read_binary_bios_measurements(), the
caller emits an error message and immediately exits.  There's no delay
between the error and the errno message.

Calling log_err() to emit an error mesage and then exiting seems to be
fine.

-- 
thanks,

Mimi

