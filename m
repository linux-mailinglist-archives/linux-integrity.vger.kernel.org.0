Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA376FFCD5
	for <lists+linux-integrity@lfdr.de>; Fri, 12 May 2023 00:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjEKWtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbjEKWtE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 18:49:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8B4496;
        Thu, 11 May 2023 15:49:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BMOAui022240;
        Thu, 11 May 2023 22:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V1HH/eyBS94jhdZ0e0imTl3Cj1IPme7uNXNqzXHW7wM=;
 b=AxhcyBFk9QhcFOQ189YxZ6bX+Xd8cfQUyz9FAC9r4HrfVf49BGcoQhd18msJtU6Uq9kL
 dOy8E7PaD+fGd4dyN2BJ43VYkM1eQhOighmjgZnZrxc9w9Ip4zAJg0im/RPFoD946cUc
 /tzL9WCEbyvfkZbFc2gfWvcZw6+6HVvmkqPnhgP6xKBjdke5OzlcLSSpRTN64QWO2f4u
 gzRHu0wRK5QYYEa3Mx9cbtroPYfeQQusgl4zcwfllQUycMEg2tCp4kCEIt5XcBrkvExY
 VDsAFW0KR7jHg0YOLCCTITznn4CUdJyr+wUIiwsA3tcymxRM63E1g9Fb1kQBKJFDxERP LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7758f66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 22:48:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BM0S1u030545;
        Thu, 11 May 2023 22:48:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81htgqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 22:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUP/IZOimBRPX/ujSsmNHHpnWOvXehG5gKToimzF9nSLqEzssGwvMWB4DaHNxnjlHKz5/PJclq3+u4J+iMcnUQt1vUG3KyyEaJPCfeSqpfxYo1fkNC//aD6dAm6AYVjky0ICaFclU7tOax5JcwC48DJii3QuiHEIEUuO9viLhoTK4nnl8YiI/m80lvQd5r5j752dCamZ6ZyDyAaG4iHdX2YsP0C4sMabwpf/57q3WJ5hkPVQGC92TwMKuBZFy3YAAeeig0bKyg7Btaf+lWeSJOAMc2yitTqCHy3YYh4njeNdXxmiinlGeJlXx/tcdVfIrf2FlgHc8WVTfbR4V1TZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1HH/eyBS94jhdZ0e0imTl3Cj1IPme7uNXNqzXHW7wM=;
 b=mCgQhKCGTkcU8bfhRqiRHSl9w6gjjpW2ldvIfdgCAOIWsJ3I/WWHuQpBWDoCxp0qUgy1yTsaLgaqoXGb6YwyondbX1AGgzL1YEVkm340JJ5Aoqz0vuLgE9BXPsOmNkAXOxtc5W7LyX9XckA9kGGILwe6K3i2O+Ck3keILKDbcu7gPzT+IBeQ1x6gVBXTN5/kPyeRcgxaAqvJY1a+cM4qSBs8B77/BDDnHa5WCLlVbS2j54rc/gWudSeXJtNogb5uXQI+vSpUZIdehtBPd8baebyfMgatx2v0GJhET4P/Ki+2VOhY1qrfytrtnagjZn4maM5O4r2q2OiqWgz25HljoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1HH/eyBS94jhdZ0e0imTl3Cj1IPme7uNXNqzXHW7wM=;
 b=NRw/tqs0CQm84Ge/mNSvpn/6KfVaiTUjSz28FuPmkyiAMYL8c3gvo5gCtvqFSl02CVqAQycTiEsDUsBpb3DMQTWNBFNnEiy+tNvdjeiRU5H4oivDga6rMcW+x/8/hhgjIdVuifaxSr+cF92iP+KpqeGumfgkS5ue5i4MuRKPfQA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB6985.namprd10.prod.outlook.com (2603:10b6:510:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 22:48:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::d074:eba3:3b2b:b48e%4]) with mapi id 15.20.6363.036; Thu, 11 May 2023
 22:48:02 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>, joeyli <jlee@suse.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] KEYS: DigitalSignature link restriction
Thread-Topic: [PATCH 1/3] KEYS: DigitalSignature link restriction
Thread-Index: AQHZgfnqJG9sa50YGUGehIJr7c/9WK9UGyiAgAGWK4A=
Date:   Thu, 11 May 2023 22:48:02 +0000
Message-ID: <347F4DEA-09BC-4069-B735-1D1B49F59CE2@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
 <20230508220708.2888510-2-eric.snowberg@oracle.com>
 <CSIYF14C6N58.7IDA6DAC9NHF@suppilovahvero>
In-Reply-To: <CSIYF14C6N58.7IDA6DAC9NHF@suppilovahvero>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH7PR10MB6985:EE_
x-ms-office365-filtering-correlation-id: ae1e214b-9192-49d5-5f42-08db5271c6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pN3ca5bKIOrzVnG57XYhUfpGkAhPszxEcw2ZZe40tA3dOniksMRIFo6sMIzNXRWtVXn+GxRfatNNJFdtM6LJbD3UhfGZUbcbx6N+OsT4y9Eo5lzTjNVdoTSMwPFSNwn3Uv9E2lrvwWnOTTj8rcS1yIttcljfqT/Qui6DOgx57mH3LB86m5ZL8UUv30fvux8MdjEHEP3sYYIAGvK39O51GhY2lOc5um6Y3FTOk/6LSfCFkOIVOWT1hcdo19wki7RP2awcEZyRkPYeKe9kdlsXV+x34zy5JxlI7CvMKqUkn45bOsHxZ9+/SdBABks0OqYvIYNcT/ooPHPURsgnW3hHonXGvKzjEYWqCJaU12cHuWqr3fi2adLk9dft5uJ/AcYsGMNMAZJ/A/kC9KUoNOwFGsApsg0AgZA70PNZOUrNl9p4Z4mWbCC7Pm0EphM7Tetj/NRjO+Dok5J9xu1yJCsyKgfijExaC2RFUmQr9tgpGF0mz0WRCyVHcyTm7EeKMemlo3hTx75d4e83igZTvl6OcSo2l0SvgDVm6beug/Vn7/8p8bMFopMhJOyDJwnxZ7bzhzarZXZMDrkwyh8NqhChdB3wYMBVIA7b1jEu7OIzgZn294qY6uM2Ce5aTS4cRWQDFuH8Z+3xSt8aQ5m1WbBuww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(38070700005)(6512007)(6506007)(316002)(186003)(71200400001)(6916009)(4326008)(64756008)(86362001)(66476007)(26005)(53546011)(91956017)(76116006)(66946007)(66446008)(66556008)(54906003)(33656002)(478600001)(36756003)(44832011)(5660300002)(6486002)(83380400001)(122000001)(7416002)(38100700002)(2906002)(8936002)(41300700001)(8676002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZ6WVU4QVN4ODNVTVlpam0rM1FuQnVYOWY3bWx2cTAxNUdIQzU2ZjEvNGxV?=
 =?utf-8?B?amtydDhQZjNEQy9vK01TaFVqb1dFWWVHV29iOGluL1Y0TWxrd1NrejFjRDVM?=
 =?utf-8?B?YW5hbTVLUS9qSmdHWmZpVElObFpRbERpVFFXb0dLTVRpa0M1SnQzS2NsaVNZ?=
 =?utf-8?B?VDN5N0NCRGJZa0lITFF5L2dNV3FlK0wzMlI0OW5Dd2JqcE82WS9NQ0piUFFM?=
 =?utf-8?B?c1NrTUloa3UvOWFReE1kdGw5bnF3MGxhTmtQaWdtRDhnWHdGQU5tK2JVSXZX?=
 =?utf-8?B?emIraG9sWmlGYTYwb2RDKzBtOWREdUN3R2dzMHlKVjgyNnYvZkxnTk5mYmZY?=
 =?utf-8?B?bzhsUEJBbmNmdWtKT1hOczFWbmgxQVBCSkZsVldITHBGT2V1Ym1SWlZhZWs2?=
 =?utf-8?B?QTBXUGYwVGpwQzZPYktyeFJmdWdVeG9qZVdMQUVyVTNWaktOby9rTCtJSlFa?=
 =?utf-8?B?eDlaTWZiSnBncFJTcEN5VnpabWIyYWRsdUxNekI2cFhYYklJVk1wcE15RU5x?=
 =?utf-8?B?ZjNFTTJRTU10ZG9qSk0vTW9JWDhDQ0hCT3cvUVRIcHJ4N3RNQ053ajNDRWJZ?=
 =?utf-8?B?ZVlaY2d1cVRzT3dPY2EzSU80cEFxWW9yVWpYVVNMbE1ZNFZTdm00TkZaTFpU?=
 =?utf-8?B?WXVLSm9tbWlCb3g2WlFwY1RnMHRKdUF0QWZnR25IYWs1MkZyRHpJbEs4Z0U5?=
 =?utf-8?B?Z1JCYzNDVWttTHNQd1NYQUtJQ1h6YXJjcFNNS3FYT1Q3VE9QdEJTbjNzNWg1?=
 =?utf-8?B?S2o4cGZxSWs2QnAyZFdoOE5pMVJ2VG4wUVZYWk1CaGpCYmFQcmF6a0ZYSG9N?=
 =?utf-8?B?QURsNkJqQTduM05JV3RSaUhpOWhDYXo0bzBLMmFzY1ZtZ3ZHSTQyMVc5U3dU?=
 =?utf-8?B?WTd3N2w5bE5GNXZVNUFvOWEwMXZ4bjdaWVJZbzRDOTUvK3V3blVLdW90YUV4?=
 =?utf-8?B?aDJUUDJMTURtemFKMHovZVhGMFA1SDVZV0FQYXdIWjlQYlRIRHNEdzdVK09O?=
 =?utf-8?B?aE54SG1vclVxaG9WU0FQOVVSL1lsbUhqd3ppMVFsSThwU2NscmQ1dEw5R0Z2?=
 =?utf-8?B?K0JzZWYvdjJYTFhxOW5wWFRvQWRpRDFDMFN4SW5yVkNoMm56Q0JnOCtaVXRI?=
 =?utf-8?B?RnA5bS9HTkw4NkxEY3Q5RkxsQWEzaFBhQVBPb3JBZEFZc2VJOW10VFZ3UUps?=
 =?utf-8?B?QXVISldhL0lrbVczZWVYaUhJK0diS2tKZGlOa1dpdmVPYU40aU1YZ0hsVlZG?=
 =?utf-8?B?bVFoMHJEbjQ3Ry9OSWtveHNDV0VEaEZwUHBWdUNuc3VrNFFsalhQTjdpWGl2?=
 =?utf-8?B?akxjZDVSRGNoRmoybG5mVnZ3a3lnK1FqbzF0TVJvME9Lc0MzUG5IZVZIQnFl?=
 =?utf-8?B?L2k1YkNEV3hsVDZmaVA2V250YVpHdU5FQkpwZDF1T3JaY1lMSFgycUI5cXJD?=
 =?utf-8?B?RHhsVFpPTHFRMm9XVTNPSUgzd1JpakRObXhlM1FZQnp3VWlYY3N1ekJaeXVB?=
 =?utf-8?B?dy9JbWJsV200c1BUeStzYTFRRlpmMWpqQkNLeEFPVnlnSWViL3RaODFJMXBX?=
 =?utf-8?B?YzdOclpoQ0ZJRkRBMXZzQW1rT01UandwdmhtTjV5ZGlNQnU4MTM5SjZXdExF?=
 =?utf-8?B?S1B6WW80TnpsclluLzFCejBXbWZMaWxmRlhMSmR3V25tam16WGh1WW1nNTRS?=
 =?utf-8?B?bXE3Y1NtTE54Tm5oQlNVdk52OGVTbjR4aXBmbVhBYU04TXBVSnhyZEsrOVox?=
 =?utf-8?B?YTRFblpuVlNDUU5INEFyUUFaY2tGcnRzNit2SytzZGQ0VG9lM3JVK3lVVDR3?=
 =?utf-8?B?dHZjSWMrMnA4ZTBEQk1FV1ljejFxNXgrSVVMYnM4L3U2MDRVT1lud0pCUjJt?=
 =?utf-8?B?WCtRanZzajlJeVlzVkM2T1ZPakxuSmxTQXM5SXlwcjRoZjlNOUFwdHEyc2Fh?=
 =?utf-8?B?elcydEZjTHBBaDQyaS96d2FXZFdPcFYya0M4K0wzOWRrbW1ObFh0ZW5ZS2Z4?=
 =?utf-8?B?djg1RzhrQ2ZNSGIzK2JjV0FuZm1vakdEdjdVODhJdy91Z2IxZ2kxc0Y5NEw0?=
 =?utf-8?B?Nk5uVjh4M1BQQzJ3SXVLRE91RDFFYTQ4OFZra2dLSUxtRlJUcWNTeE85Ui8w?=
 =?utf-8?B?OU9NYldPeEhOWUg0MG1JRTVYYUJqRFJRUE9CVzl6cjJidDBqYXRoUndqZkJI?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A49172EED11D042B477D503694D9F74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUNmMXI1aHB2Z1pZR2FTUDZacGxjR3d2ZDRXaXZZL2lMbmFSMUhIUXFqemxO?=
 =?utf-8?B?Vkk3alVIUTNraWI0YkM4ZGMyZFBBblkvWk9GTU1hUHMxS29sNFp3ejVObHJw?=
 =?utf-8?B?ZW9YcENCa2VjQmpYM0NNMWdNQjB6Kzc0dXpWQmt2Y1k5dGhEanVISm1hS3FX?=
 =?utf-8?B?QmsxbkFOaFUxaUgyY0VtNlNIWkFhUUV0RklxZ3JyWXJmZXhRUGEvSXFoSTZr?=
 =?utf-8?B?ckZIaVA1ZDVvMWt6L0FxSXNwR3hVZEZSU21zdHBrMSs3cjhVMENTYXd0bDBV?=
 =?utf-8?B?YW5LSXdjZU5ySU90TFlQdW9oVFJRVlUvdmtWd20yUUN2YjBhdHkwU1JlSFZ0?=
 =?utf-8?B?ZmxUeUZJMU5tUW9pbVYxVnJ0UXA2YVNnc25jUXNsMGxUT21zU3RReXBPcXhR?=
 =?utf-8?B?MGRpVCtyellhakhEM1hBdUtVQnUrZTNCVHVyUS9GNFNIQzFDUmFCUm5kMVRV?=
 =?utf-8?B?TWdvMnUyaFE1NTBycDlIRzBPMUpicng0Nnp0MjJON29OWFVuMWVaMHU4YS9Y?=
 =?utf-8?B?MHRMY3Q2NHNUOS9QbWFwMmFPSFRmaWZNUlJhRmJacHhtSXZVU01KZHdXZ0RW?=
 =?utf-8?B?bFltZkpZcjlQaGg1YjJUdHBlK29LNnpCMitJSC9FUGM0YWZPSHNvWEN4SERK?=
 =?utf-8?B?YXdpUGtORlUrbTBqdHJZb21kcGxUQThDNzVNQTFzdStNbi94TXBYckNPZ3Ft?=
 =?utf-8?B?OHBFSmI1d3ZlUEdWMXRaZlFURldmYXJxMFVPQnJFQ3pKUjVwYUpjRFpvWm0r?=
 =?utf-8?B?dzZCL2xnR1hrL3hoZjM5YTNKcnZ4VGhFam5EZGlYYjJPOCtJcVR0N3Z3Wm5q?=
 =?utf-8?B?TFBhaWxNWGNxdVB1bFp3Y1pRbmlJbTFZQzg1c28ra3JWb0lHMk8vQ3k3Rjdn?=
 =?utf-8?B?TlRXdUNtU1lQZFg3Tnpkc21CNHh6b205R09mN1NCV2tTOUw5ZjhIMGd1R0Fq?=
 =?utf-8?B?SS84b3k3UVZYYVUrODNNMVpoTTg2cFVRSCtDOUxtN094TjByT1V1ZTZMZkM5?=
 =?utf-8?B?UUFIOVpPaW5kV2RYa3RPWEN1N0pvTStzajNpSDRhck5vZXRGTSt2a0tCV0xn?=
 =?utf-8?B?R0RoNDN1M2NISkhUM0ZXdElCV2pBNFdEbjlsMkFMTHhXSjlYMVZBUlVVTElF?=
 =?utf-8?B?eGJEMWJmZXBXK1c0Mk5qQ1h4dnIxa0t6RkpvNmd4WmNvdWJQdDJBczREY0ZS?=
 =?utf-8?B?K20ydEpUb0gzODVNY0o1eS91RVBRSUtnam9EckNOUWRQM1J2N1RaSkZsUGFW?=
 =?utf-8?B?a1dnck1nYzJsYVJWVUlFTXBzL3BvZ2c0RU5iclNldVNNUFlwV0VEdHZuTDk0?=
 =?utf-8?B?bmU5RS9OMlBEaTlISFJoUTdWRjZ0ZnAwcEROdFowZm1hTTJsYUxyMUZFRXB1?=
 =?utf-8?B?aUQxZ3E0VTZlV2xXbWkrOC91VGdhWEg3UW1LV0plZjRDZHBXcFplMjNwbHpw?=
 =?utf-8?B?QllBV0VMYVZYM0R4VlBJeGhKWThtM1k2SXdlWnJqR2ZDUXZpem53ckZoRTRS?=
 =?utf-8?Q?OfsE2wV/t2nGpYOkmsdz1uIVxd5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1e214b-9192-49d5-5f42-08db5271c6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 22:48:02.1489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYla7RpIBwsLeagGI3mFS2dSDhGRPEmYItOn//dUKD687exPFTpAGPtefA8iUZcjgqoKz9sWwQPPu0fFrdydbQHrPE74sGcyAAUwA/j9vcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305110194
X-Proofpoint-GUID: 8eMLyYv8DsrxcgTe8vOb71qubSyL5Zeq
X-Proofpoint-ORIG-GUID: 8eMLyYv8DsrxcgTe8vOb71qubSyL5Zeq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gTWF5IDEwLCAyMDIzLCBhdCA0OjM0IFBNLCBKYXJra28gU2Fra2luZW4gPGphcmtr
b0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSBNYXkgOSwgMjAyMyBhdCAxOjA3IEFN
IEVFU1QsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBBZGQgYSBuZXcgbGluayByZXN0cmljdGlv
bi4gIFJlc3RyaWN0IHRoZSBhZGRpdGlvbiBvZiBrZXlzIGluIGEga2V5cmluZw0KPj4gYmFzZWQg
b24gdGhlIGtleSBoYXZpbmcgZGlnaXRhbFNpZ25hdHVyZSB1c2FnZSBzZXQuIEFkZGl0aW9uYWxs
eSwgdmVyaWZ5DQo+PiB0aGUgbmV3IGNlcnRpZmljYXRlIGFnYWluc3QgdGhlIG9uZXMgaW4gdGhl
IHN5c3RlbSBrZXlyaW5ncy4gIEFkZCB0d28NCj4+IGFkZGl0aW9uYWwgZnVuY3Rpb25zIHRvIHVz
ZSB0aGUgbmV3IHJlc3RyaWN0aW9uIHdpdGhpbiBlaXRoZXIgdGhlIGJ1aWx0aW4NCj4+IG9yIHNl
Y29uZGFyeSBrZXlyaW5ncy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8
ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBjZXJ0cy9zeXN0ZW1fa2V5cmlu
Zy5jICAgICAgICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBj
cnlwdG8vYXN5bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMgfCA0NCArKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gaW5jbHVkZS9jcnlwdG8vcHVibGljX2tleS5oICAgICAgIHwgMTEgKysrKysr
Kw0KPj4gaW5jbHVkZS9rZXlzL3N5c3RlbV9rZXlyaW5nLmggICAgIHwgMTEgKysrKysrKw0KPj4g
NCBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
Y2VydHMvc3lzdGVtX2tleXJpbmcuYyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IGluZGV4
IGE3YTQ5YjE3Y2ViMS4uNDI0OWM0OWJkNDNiIDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvc3lzdGVt
X2tleXJpbmcuYw0KPj4gKysrIGIvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gQEAgLTUxLDYg
KzUxLDI3IEBAIGludCByZXN0cmljdF9saW5rX2J5X2J1aWx0aW5fdHJ1c3RlZChzdHJ1Y3Qga2V5
ICpkZXN0X2tleXJpbmcsDQo+PiAJCQkJCSAgYnVpbHRpbl90cnVzdGVkX2tleXMpOw0KPj4gfQ0K
Pj4gDQo+PiArLyoqDQo+PiArICogcmVzdHJpY3RfbGlua19ieV9kaWdzaWdfYnVpbHRpbiAtIFJl
c3RyaWN0IGRpZ2l0YWxTaWduYXR1cmUga2V5IGFkZGl0aW9ucw0KPj4gKyAqICAgYnkgdGhlIGJ1
aWx0LWluIGtleXJpbmcuDQo+IA0KPiBCVFcsIGRvZXMgY2hlY2twYXRjaCBjb21wbGFpbiBpZiB5
b3UgcHV0IHRoYXQgdG8gYSBzaW5nbGUgbGluZSAoSSBkb24ndA0KPiBrbm93IHRoaXMpPw0KPiAN
Cj4gSWYgbm90LCBJIHdvdWxkIGp1c3QgcHV0ICJSZXN0cmljdCBieSBkaWdpdGFsU2lnbmF0dXJl
4oCdDQoNCkl0IGxvb2tzIGxpa2UgY2hlY2sgcGF0Y2ggd2lsbCBhbGxvdyB1cCB0byAxMDAgY2hh
cnMuICBJIHdpbGwgdXBkYXRlIGl0IHRvIGEgc2luZ2xlIGxpbmUuDQpUaGFua3MuDQoNCg==
